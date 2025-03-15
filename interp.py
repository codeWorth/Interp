import numpy as np
from scipy.io import wavfile
import argparse

def integersWithin(a, b):
    """
    Generates integers within the range [a, b).
    Returns a 1-D array
    """

    return np.arange(np.ceil(a), np.ceil(b))

def upsampleCurve(startK, endK, startOffset, endOffset, length, sampleRate):
    """
    Generates a sequence of time values in seconds to sample the input data at. 
    Output sample rate will change linearly from startK*sampleRate to endK*sampleRate.

    Args:
        startK (float): starting ratio between original and upsampled sample rate. No more than 1.
        endK (float): end ratio between original and upsampled sample rate. No more than 1.
        startOffset (float): How long, in seconds, to hold at startK before beginning to increase.
        endOffset (float): How long, in seconds, to hold at endK after reaching it.
        length (int): Number of samples in data.
        sampleRate (int): Sample rate of data.
    Returns:
        NDArray: array of second values to sample at.
    """

    # ending upsampled time should be less than (length/samplerate) but more than ((length-1)/samplerate)

    sr1 = startK / sampleRate # technically it's not sample rate 1, but rate per sample 1, unideal variable name
    sr2 = endK / sampleRate

    # duration in seconds within the original sample rate
    sDuration = length/sampleRate
    sCurveDuration = sDuration - startOffset - endOffset

    startHoldSamples = startOffset/sr1 # non-integer number of samples accounts for samples not lining up, will be handled later
    endHoldSamples = endOffset/sr2

    """
    Solves for (A, B, n) given the following contraints:
        p(x) = Ax^2 + Bx
        p(n) = sCurveDuration
        p'(0) = sr1
        p'(n) = sr2
    """
    
    curveSamples = 2*sCurveDuration / (sr1 + sr2)
    curveA = (sr2 - sr1) / (2 * curveSamples)
    curveB = sr1
        
    startU = integersWithin(0, startHoldSamples) * sr1

    midUx = integersWithin(startHoldSamples, startHoldSamples+curveSamples) - startHoldSamples
    midU = curveA * np.square(midUx) + curveB * midUx + startOffset

    endUx = integersWithin(startHoldSamples+curveSamples, startHoldSamples+curveSamples+endHoldSamples) - startHoldSamples - curveSamples
    endU = endUx * sr2 + (startOffset + sCurveDuration)

    outU = np.concatenate([startU, midU, endU])
    print("Generated", outU.shape[0], "sample times:", outU)
    if startU.shape[0] > 0:
        print("Start to mid", (midU[0] - startU[-1]))
    if endU.shape[0] > 0:
        print("Mid to end", (endU[0] - midU[-1]))
    print("Durations =", startHoldSamples, curveSamples, endHoldSamples)
    print("Counts =", startU.shape[0], midU.shape[0], endU.shape[0])

    return outU

def fast_sinc_interp(x, s, u, window_size=1023):
    """
    Uses sinc interpolation, but only uses samples in a window around the target sample.
    Args:
        x (NDArray): Signal to be interpolated.
        s (NDArray): Time points of x.
        u (NDArray): Time points to upsample to.
        window_size (int): Size of window around each target sample. Must be odd, default is 1023.
    Returns:
        NDArray: Upsampled signal
    """

    """
    1. Find the indecies of s which are closest to the values in u (i.e. u[0] is closest to s[0], u[10] is closest to s[6])
    2. Extract the N surrounding values in s and x to x_wind and s_wind
    3. Perform x_wind * sinc((u-s_wind)/(s[1]-s[0]))
    """

    assert (window_size%2 == 1)
    assert (x.shape[0] == s.shape[0])

    print("Fast interp", s.shape[0], "=>", u.shape[0], ", window size =", window_size)

    s_i = 0
    s_indecies = np.empty(u.shape[0], dtype=np.int32)
    for u_i in range(u.shape[0]):
        while (s_i < s.shape[0]-1 and u[u_i] > s[s_i]): # this produces non-ideal results if s increases faster than u
            s_i += 1

        s_indecies[u_i] = s_i


    delta = s[1] - s[0]
    x = np.pad(x, (window_size//2, window_size//2), constant_values=(0,0))
    s = np.pad(s, (window_size//2, window_size//2), constant_values=(0,0))

    x_wind = np.lib.stride_tricks.sliding_window_view(x, window_size)[s_indecies]
    s_wind = np.lib.stride_tricks.sliding_window_view(s, window_size)[s_indecies]

    dt = (u[:,None]-s_wind)/delta
    print("...dt")
    sinc_ = np.sinc(dt)
    print("...sinc, error less than", np.max(sinc_[window_size//2:-window_size//2,0]))
    interpolated = np.sum(x_wind*sinc_, axis=1)
    print("...dot product, finished")
    return interpolated

def sinc_interpolation(x, s, u):
    """
    Sinc interpolation.
    Args:
        x (NDArray): signal to be interpolated, can be 1D or 2D
        s (NDArray): time points of x (*s* for *samples*) 
        u (NDArray): time points of y (*u* for *upsampled*)
    Returns:
        NDArray: interpolated signal at time points *u*
    Reference:
        This code is based on https://gist.github.com/endolith/1297227
        and the comments therein.
    """
    sinc_ = np.sinc((u - s[:, None])/(s[1]-s[0]))
    return np.dot(x, sinc_)

def main(inFile, outFile, startRate, endRate, startHold, endHold, useSlow):
    samplerate, data = wavfile.read(inFile)
    print("Loaded", samplerate, data.shape, data.dtype, "... rate from", startRate, "to", endRate)

    length = data.shape[0]

    s = np.arange(0, length) * (1 / samplerate)
    u = upsampleCurve(startRate, endRate, startHold, endHold, length, samplerate)

    if useSlow:
        interpFunc = sinc_interpolation
    else:
        interpFunc = fast_sinc_interp

    outData = np.empty((u.shape[0], 2), dtype=np.int32)
    outData[:,0] = interpFunc(data[:,0], s, u).astype(np.int32)
    outData[:,1] = interpFunc(data[:,1], s, u).astype(np.int32)
        
    wavfile.write(outFile, samplerate, outData.astype(np.int32))
    print("Wrote output data to", outFile)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        prog="Sinc Interpolation",
        description="Changes the sample rate of a signal using sinc interpolation.")

    parser.add_argument("-i", "--input", help="Input file name.", required=True)
    parser.add_argument("-s", "--start", help="Starting sample rate, as a ratio to the original sample rate.", default=1.0, type=float)
    parser.add_argument("-e", "--end", help="Ending sample rate, as a ratio to the original sample rate.", default=1.0, type=float)
    parser.add_argument("-d", "--delay", help="Time in seconds to hold at the starting sample rate before beginning to change.", default=0.0, type=float)
    parser.add_argument("-H", "--hold", help="Time in seconds to hold at the ending sample rate once reached.", default=0.0, type=float)
    parser.add_argument("-S", "--slow", action="store_true", help="Use full sinc interpolation without windowing (not recommended).")
    parser.add_argument("output", help="Output file name.")

    args = parser.parse_args()

    main(args.input, args.output, args.start, args.end, args.delay, args.hold, args.slow)