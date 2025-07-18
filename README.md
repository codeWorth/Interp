Simple sample rate interpolation using sinc. Allows for smooth variable sample rates (hold time, changing period, hold time).

Example:
`interp -i "file.wav" -s 0.8 -e 1.0 -d 1.2 -H 0.8 "outfile.wav"`

I built with the following on Windows with gcc:
`cmake -DCMAKE_BUILD_TYPE=Release -GNinja ..`
`cmake -build .`