![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout : the miniMAC unit

MAC as in "Media Access Controller", one layer of a network protocol stack. Though inspired by Ethernet/IEEE802.3, it is incompatible and ultimately it only shares the twisted pairs cables and 8P8C connector.

- [Read this project's documentation](docs/info.md)

- [Read about its design on Hackaday](https://hackaday.io/project/198914)

## What is this miniMAC

This unit (de)scrambles 16-bit data (+ a 17th bit for data/control framing). The 18-bit result is suitable for feeding an upcoming PHY for serialisation and line coding. Due to pin constraints, the data are transmitted in two cycles.

This unit combines two bleeding-edge circuits:

- the gPEAC18 unit is an additive-based scrambler that combines the 17 bits and creates an extra check bit.

- the Hammer18 unit is a non-linear XOR-based scrambler that boosts the Hamming distance on the 18 bits.

Together they provide a very strong and early error detection, tailored for early retransmition. Higher levels of the protocol will detect anomalous conditions and reset the link's state.

## What next?

This is a VHDL to Verilog+IHP PDK port. I'll try to get 2 boards to test both coder and decoder in a chain, let's hope it works. Then maybe I'll have a decent PHY to test...
