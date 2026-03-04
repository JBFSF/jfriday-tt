<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

my project is a simple 4bit ALU with 4 operations, add, subtract, floor log2, and square root. it has 2 4 bit inputs a_i and b_i that are the inputs that get operated on and one 4 bit input operation_i that determines which operation the ALU executes via one hot encoding

## How to test

run 'make' in the test directory to run the cocotb python test for the module, which runs random input operations on all the different operators in the module and checks their outputs. The math is compared to python for the same inputs, masked to match the bits and done 10 test for each case, which covers most cases for a 4bit design.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
