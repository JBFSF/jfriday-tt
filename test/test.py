# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
import random
import math


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.a_i.value = random.randint(0,255)
    dut.b_i.value = random.randint(0,255)
    dut.operation_i.value = 0
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    dut.operation_i.value = 0
    for i in range(10):
        dut.a_i.value = random.randint(0,255)
        dut.b_i.value = random.randint(0,255)
        await ClockCycles(dut.clk, 1)
        assert dut.y_o.value == 0

    dut.operation_i.value = 1
    for i in range(10):
        a_i = random.randint(0,255)
        b_i = random.randint(0,255)
        dut.a_i.value = a_i
        dut.b_i.value = b_i
        await ClockCycles(dut.clk, 2)
        assert dut.y_o.value == (a_i + b_i) & 0xFF
        
    dut.operation_i.value = 2
    for i in range(10):
        a_i = random.randint(0,255)
        b_i = random.randint(0,255)
        dut.a_i.value = a_i
        dut.b_i.value = b_i
        await ClockCycles(dut.clk, 2)
        assert dut.y_o.value == (a_i - b_i) & 0xFF
    
    dut.operation_i.value = 4
    for i in range(10):
        a_i = random.randint(0,255)
        dut.a_i.value = a_i
        await ClockCycles(dut.clk, 2)
        assert dut.y_o.value == int(math.log2(a_i))
        
    dut.operation_i.value = 8
    for i in range(10):
        a_i = random.randint(0,255)
        dut.a_i.value = a_i
        await ClockCycles(dut.clk, 2)
        assert dut.y_o.value == round(math.sqrt(a_i))

