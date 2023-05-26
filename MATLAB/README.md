**Matlab files**

You will find the algorithm themself but also some handy scripts for import and exporting between matlab and the HDL implementation.

--- The algorithms
- There is the simple and complex algorithm, apptly named so. *LUT_generator.m* creates the lookup table used in the complex algorithm but a finished *LUTv.mat* file is included.

--- Testing
- For testing a algorithm you will need input vectors, either sampled audio or simulated. For simulation there is the *soundstageSim.m* which by a single or stereo channel audio file virtually plays the sound and records it through four microphones.

--- Handy tools
- For importing samples from ethernet capture via WireShark there is the *EthernetImporter.m*. This takes the txt log file created and scans for sample data.

- For importing of sound.txt file or output log file there is the *soundImporter.m*. This takes ascii coded binary numbers and converts it to matlab variable. It expects newline between each value.

- For exporting simulated sounds to use as testvectors in behavioral simulation there is the *soundExporter.m*.

- To create filter coefficients and convert them to binary there is the *digital_filter.m*
