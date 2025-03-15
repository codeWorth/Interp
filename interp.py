import numpy as np
from scipy.io import wavfile

semitone = 0.06
newRate = 1 - 0.5*semitone

startHold = 1.5
endHold = 1.5

padding = 512
halfFadeSize = 500
fadeInBefore = np.linspace(0, 0.5, halfFadeSize, endpoint=False)
fadeInAfter = np.linspace(0.5, 1, halfFadeSize, endpoint=False)
fadeOutBefore = np.linspace(1, 0.5, halfFadeSize, endpoint=False)
fadeOutAfter = np.linspace(0.5, 0, halfFadeSize, endpoint=False)

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
    print("Start to mid", (midU[0] - startU[-1]))
    print("Mid to end", (endU[0] - midU[-1]))
    print("Durations =", startHoldSamples, curveSamples, endHoldSamples)
    print("Counts =", startU.shape[0], midU.shape[0], endU.shape[0])

    return outU

def fast_sinc_interp(x, s, u):
    # when finding sinc_, align both arrays to the start of each other (u[0] - s[0])
    # columns to the left of u[0] - s[0] are u[n:] - s[:-n], aligned to the top
    # columns to the right of u[0] - s[0] are u[:-n] - s[n:], aligned to the bottom
    # all other values are 0
    # to get diags aligned, b = np.lib.stride_tricks.as_strided(out, (3,3), (24,32))
    # where (3,3) is (m,n), n=window, m=(length of data-n//2)
    # (24,32) is (I,J), where I=orig stride value and J=I+sizeof(dtype)
    # to get data subsections, a = np.lib.stride_tricks.sliding_window_view(x, 3), where 3 is n
    # to do dot product, np.sum(a*b, axis=1)

    # its best if window size is odd
    window_size = 5
    length = x.shape[0]-window_size//2
    
    diagLen = np.min([s.shape[0], u.shape[0]])
    diags = np.zeros((diagLen, window_size), dtype=x.dtype)

    # left side diags
    for k in range(1, window_size//2+1):
        subUEnd = np.min([u.shape[0], k+diagLen])
        subU = u[k:subUEnd]
        subS = s[:subU.shape[0]]

        # alligned to top of diags, so ignore end # = diff
        skip = diagLen - subU.shape[0]
        if skip > 0:
            diags[:-skip,(window_size//2-k)] = subU - subS
        else:
            diags[:,(window_size//2-k)] = subU - subS

    # center diag
    diags[:,window_size//2] = u[:diagLen] - s[:diagLen]

    # right side diags
    for k in range(1, window_size//2+1):
        # s[k:] must be length diagLen at most
        subSEnd = np.min([s.shape[0], k+diagLen])
        subS = s[k:subSEnd]
        # since subS is diagLen at most, it's never longer than u
        # u length must be equal to s
        subU = u[:subS.shape[0]]

        # alligned to bottom of diags, so skip ahead by diff
        skip = diagLen - subS.shape[0] # never less than 0 since subS.shape[0] <= diagLen
        diags[skip:,(window_size//2+k)] = subU - subS

        print(k, subSEnd, subS, subU, skip)

    diagsStrided = np.lib.stride_tricks.as_strided(diags, 
        (diagLen-window_size//2, window_size), 
        (diags.strides[0], diags.strides[0] + diags.strides[1]))

    return diags, diagsStrided

def sinc_interpolation(x, s, u):
    """Whittaker–Shannon or sinc or bandlimited interpolation.
    Args:
        x (NDArray): signal to be interpolated, can be 1D or 2D
        s (NDArray): time points of x (*s* for *samples*) 
        u (NDArray): time points of y (*u* for *upsampled*)
    Returns:
        NDArray: interpolated signal at time points *u*
    Reference:
        This code is based on https://gist.github.com/endolith/1297227
        and the comments therein.
    TODO:
        * implement FFT based interpolation for speed up
    """
    sinc_ = np.sinc((u - s[:, None])/(s[1]-s[0]))
    return np.dot(x, sinc_)

def main():
    samplerate, data = wavfile.read('tts_speedsct_nolmt.wav')
    print("Loaded", samplerate, data.shape, data.dtype, "... New rate of", newRate)

    count = 0
    size = samplerate // 4
    maxCount = data.shape[0] // size
    print("Count", maxCount, "differs by", (data.shape[0] - maxCount*size))

    s = np.arange(0, size*maxCount) * (1 / samplerate)
    u = upsampleCurve(newRate, 1.0, startHold, endHold, s.shape[0], samplerate)
    outData = np.zeros((u.shape[0], 2), dtype=np.int32)
    
    while (count < maxCount):
        nonPadStart = count*size

        if count == 0:
            sSize = size + padding # pad right side

            startSIndex = nonPadStart
            endSIndex = startSIndex + sSize

            startUIndex = np.searchsorted(u, s[startSIndex])
            endUIndex = np.searchsorted(u, s[endSIndex])

            finalUSize = np.searchsorted(u, s[nonPadStart + size]) - startUIndex
            startUPadding = 0

        elif count < maxCount-1:
            sSize = size + padding*2 # pad both sides

            startSIndex = nonPadStart - padding
            endSIndex = startSIndex + sSize

            startUIndex = np.searchsorted(u, s[startSIndex])
            endUIndex = np.searchsorted(u, s[endSIndex])

            finalUSize = np.searchsorted(u, s[nonPadStart + size]) - np.searchsorted(u, s[nonPadStart])
            startUPadding = np.searchsorted(u, s[nonPadStart]) - np.searchsorted(u, s[startSIndex]) # difference between the neg padded start and the real start

        else:
            sSize = size + padding # pad left side

            startSIndex = nonPadStart - padding
            endSIndex = startSIndex + sSize
            assert endSIndex == s.shape[0]

            startUIndex = np.searchsorted(u, s[startSIndex])
            endUIndex = u.shape[0]

            finalUSize = endUIndex - np.searchsorted(u, s[nonPadStart])
            startUPadding = np.searchsorted(u, s[nonPadStart]) - np.searchsorted(u, s[startSIndex])

        
        print("s:", startSIndex, endSIndex)
        print("u:", startUIndex, endUIndex)
        print("output trim:", startUPadding, finalUSize)

        left = data[startSIndex:endSIndex, 0]
        right = data[startSIndex:endSIndex, 1]

        outL = sinc_interpolation(left, s[startSIndex:endSIndex], u[startUIndex:endUIndex])
        outR = sinc_interpolation(right, s[startSIndex:endSIndex], u[startUIndex:endUIndex])

        fadeStOff = 0
        fadeNdOff = 0
        outI = startUIndex+startUPadding

        if startUPadding > 0 and halfFadeSize > 0:
            print("Fade in")
            fadeStOff = halfFadeSize

            outL[startUPadding-halfFadeSize:startUPadding] *= fadeInBefore
            outL[startUPadding:startUPadding+halfFadeSize] *= fadeInAfter
            
            outR[startUPadding-halfFadeSize:startUPadding] *= fadeInBefore
            outR[startUPadding:startUPadding+halfFadeSize] *= fadeInAfter

        if outI+finalUSize < outData.shape[0] and halfFadeSize > 0:
            print("Fade out")
            fadeNdOff = halfFadeSize

            outL[startUPadding+finalUSize-halfFadeSize:startUPadding+finalUSize] *= fadeOutBefore
            print(startUPadding+finalUSize, startUPadding+finalUSize+halfFadeSize)
            print(outL.shape)
            outL[startUPadding+finalUSize:startUPadding+finalUSize+halfFadeSize] *= fadeOutAfter
            
            outR[startUPadding+finalUSize-halfFadeSize:startUPadding+finalUSize] *= fadeOutBefore
            outR[startUPadding+finalUSize:startUPadding+finalUSize+halfFadeSize] *= fadeOutAfter

        
        outData[outI-fadeStOff:outI+finalUSize+fadeNdOff, 0] += outL[startUPadding-fadeStOff:startUPadding+finalUSize+fadeNdOff].astype(np.int32)
        outData[outI-fadeStOff:outI+finalUSize+fadeNdOff, 1] += outR[startUPadding-fadeStOff:startUPadding+finalUSize+fadeNdOff].astype(np.int32)

        print("Output", count, startUIndex+startUPadding)
        count += 1
        
    wavfile.write('tts_speedsct_nolmt_combo.wav', samplerate, outData)
    print("Wrote output data.")

if __name__ == '__main__':
    main()