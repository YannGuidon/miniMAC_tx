# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

# Test the Hammer18 scrambler in direct, encoding and decoding modes.

enable_bypass = True
enable_encode = False
enable_decode = True

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

# outputs:
Dout_8     =   1
QEN        =   2
CLK_out    =   4
Zero       =   8
#inputs:
DEN        =  16
Encode     =  32
Decode     =  64
Din_8      = 128

async def reset_state(dut):
  dut.rst_n.value = 0
  await ClockCycles(dut.clk, 3)
  dut.rst_n.value = 1
  await ClockCycles(dut.clk, 3)

async def input_parameter(val, mode, dut):
  dut.ui_in.value = val & 255
  # MSB and DEN set
  dut.uio_in.value = mode | DEN | (Din_8 & (val >> 1))
  await ClockCycles(dut.clk, 1)
  dut.ui_in.value = (val >> 9) & 255
  # clear DEN, set MSB
  dut.uio_in.value = mode | (Din_8 & (val >> 10))
  await ClockCycles(dut.clk, 1)

async def output_parameter(dut):
  timeout = 0
  while (int(dut.uio_out.value[1])) != 1:
    timeout = timeout + 1
    if timeout > 10:
      print("timeout !")
      assert false
      return -1
    await ClockCycles(dut.clk, 1)

  #print("waited " + str(timeout))  
  # LSB first:
  #print("phase0: " + str(dut.uio_out.value) + " : " + str(dut.uo_out.value))
  val = int(dut.uo_out.value) + (int(dut.uio_out.value[0]) << 8)
  #print("uo=" + bin(int(dut.uo_out.value)) + "   uio=" + bin(int(dut.uio_out.value))  + "   QEN=" + str(dut.uio_out.value[1]))
  await ClockCycles(dut.clk, 1)
  #print("phase1: " + str(dut.uio_out.value) + " : " + str(dut.uo_out.value))
  assert dut.uio_out.value[1] == 0
  #print("uo=" + bin(int(dut.uo_out.value)) + "   uio=" + bin(int(dut.uio_out.value))  + "   QEN=" + str(dut.uio_out.value[1]))
  return val + (( int(dut.uo_out.value) + ((int(dut.uio_out.value[0])<<8) << 9)


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

sequence = [
 10,      # index=10
 3147,
 228245,
 77,
 227223,
 227216,
 86,
 96676,
 134782,
 134777 ]  # index=19

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

  # Test in direct mode (mode=0)
  if enable_bypass == True:
    await reset_state(dut)  
    dut._log.info("Starting Direct Mode")
    for x in vectors:
      i = int(x[0],2)
      v = int(x[1],2)
      print("testing " + x[0] + " => " + x[1]);
      await input_parameter(i, 0, dut)  # Encode = Decode = 0 => direct mode
      o = await output_parameter(dut)
      print(" - found                 " + bin(o + (1 << 20)))
      assert v == o
    await ClockCycles(dut.clk, 6)

  #  Test in encode mode (mode=Encode)
  if enable_encode == True:
    await reset_state(dut)  
    dut._log.info("Starting Encode Mode")
    i = 10
    for x in sequence:
      await input_parameter(i, Encode, dut)
      t = await output_parameter(dut)
      print(str(i) + " : " + str(t) + "   expected "+ str(x))
      assert t == x
      i = i+1

  #  mode=Decode
  if enable_decode == True:
    await reset_state(dut)  
    dut._log.info("Starting Decode Mode")
    i = 10
    for x in sequence:
      await input_parameter(x, Decode, dut)
      t = await output_parameter(dut)
      print(str(i) + " : " + bin((1 << 20) + (i ^ t)) + "  " + str(t))
      #assert t == i
      i = i+1

  await ClockCycles(dut.clk, 6)
  dut._log.info("Done.")
