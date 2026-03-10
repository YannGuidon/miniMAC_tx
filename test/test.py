# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

#  assign uo_out     = Dout9[7:0];
#  assign Din9[7:0]  = ui_in;
#  assign uio_out[0] = Dout9[8];
#  assign uio_out[1] = QEN;
#  assign uio_out[2] = CLK_out;
#  assign uio_out[3] = Zero;
#  assign DEN        = uio_in[4];
#  assign Encode     = uio_in[5];
#  assign Decode     = uio_in[6];
#  assign Din9[8]    = uio_in[7];

Dout_8     =   1
QEN        =   2
CLK_out    =   4
Zero       =   8
DEN        =  16
Encode     =  32
Decode     =  64
Din_8      = 128

def input_parameter(val):
  dut.ui_in.value = val & 255
  # MSB and DEN set
  dut.uio_in.value = (dut.uio_in.value & (255-(Din_8))) | DEN | (Din_8 & (val >> 1))
  await ClockCycles(dut.clk, 1)
  dut.ui_in.value = val >> 9
  # clear DEN, set MSB
  dut.uio_in.value = (dut.uio_in.value & (255-(Din_8+DEN))) | (Din_8 & (val >> 10))


def output_parameter():
  timeout = 0
  while (dut.uio_out.value & QEN) == 0:
    timeout = timeout + 1
    if count > 10:
      return -1
    await ClockCycles(dut.clk, 1)
  val = dut.uo_out.value + (dut.uio_out.value & Dout_8)<<8)
  # expect DEN=0 here
  await ClockCycles(dut.clk, 1)
  return val+ ((dut.uo_out.value + (dut.uio_out.value & Dout_8)<<8) << 9)
  

# Test vectors for a direct Hammer18 lookup.
vectors = [
["111111111111111111", "101011111000110100"],
["000000000000000000", "000000000000000000"],
["000000000000000001", "110111011111011001"],
["000000000000000010", "110111011111011111"],
["000000000000000100", "110111101111011111"],
["000000000000001000", "110111101110011111"],
["000000000000010000", "010111100110110101"],
["000000000000100000", "110001101011001010"],
["000000000001000000", "000000011111111000"],
["000000000010000000", "101110111001000000"],
["000000000100000000", "111111000010100000"],
["000000001000000000", "111111011111111001"],
["000000010000000000", "111110111111111001"],
["000000100000000000", "111110111111110101"],
["000001000000000000", "001101111111010101"],
["000010000000000000", "000111100010110101"],
["000100000000000000", "110111000000100110"],
["001000000000000000", "111111000000101100"],
["010000000000000000", "100001001101110000"],
["100000000000000000", "000000011111111010"],
["111111111000000000", "011100010000010101"],
["000000000111111111", "110111101000100001"],
["101010101010101010", "100110111110100101"],
["010101010101010101", "001101000110010001"],
["110111011111011001", "011011011100100111"],
["110001101011001010", "000011011010101011"],
["000000011111111010", "110110111000100111"],
["011011011100100111", "101100110110001111"],
["001101111111010101", "111100010010000001"],
["011011010110110101", "011101101001011100"],
["100100101001001010", "110110010001101000"],
["110110010001101000", "101001010101001101"],
["111100010010000001", "001110001011100000"],
["110110111000100111", "101000101011111111"],
["100110111110100101", "101111000010110000"],
["000011011010101011", "100011000001110011"],
["101000101011111111", "110110010101011011"],
["100011000001110011", "101100010000011011"],
["001110001011100000", "101111110000110100"]]

#for x in vectors:
#  print(str(int(x[0],2)) + " = " + str(int(x[1],2)));



@cocotb.test()
async def test_project(dut):
  dut._log.info("Start")

  # Set the clock period to 10 us (100 KHz)
  clock = Clock(dut.clk, 10, unit="us")
  cocotb.start_soon(clock.start())

  # Reset
  dut._log.info("Reset")
  dut.ena.value = 1
  dut.ui_in.value = 0
  dut.uio_in.value = 0
  dut.rst_n.value = 0
  await ClockCycles(dut.clk, 3)
  dut.rst_n.value = 1
  await ClockCycles(dut.clk, 3)

  dut._log.info("Starting")
  for x in vectors:
    i = int(x[0],2)
    o = int(x[1],2)
    print("testing " + x[0] + " = " + x[1]);
    input_parameter(i)
    await ClockCycles(dut.clk, 4)

  # Set the input values you want to test
  #dut.ui_in.value = 20
  #dut.uio_in.value = 30

  # Wait for one clock cycle to see the output values
  await ClockCycles(dut.clk, 10)

  # The following assersion is just an example of how to check the output values.
  # Change it to match the actual expected output of your module:
  #assert dut.uo_out.value == 50
