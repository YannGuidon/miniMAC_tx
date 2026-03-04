![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout : the miniMAC unit

- [Read the documentation for project](docs/info.md)

- [Read about its design on Hackaday](https://hackaday.io/project/198914)

## What is this miniMAC

This unit (de)scrambles 16-bit data (+ a 17th bit for data/control framing). The 18-bit result is suitable for sending to a PHY for serialisation and line coding. Due to pin constraints, the data are transmitted in DDR, using both edges of the clock signal.

This unit combines two sophisticated systems:
- the gPEAC18 unit is an additive-based scrambler that combines the 17 bits and creates an extra check bit.
- the Hammer18 unit is a non-linear XOR-based scrambler that boosts the Hamming distance on the 18 bits.
Together they provide a very strong and early error detection, tailored for early retransmition.

## What next?

This is a VHDL to Verilog port. I'll try to get 2 boards to test both coder and decoder in a chain, let's hope it works.
