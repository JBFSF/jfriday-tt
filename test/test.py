# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
import random
import math


def pack_inputs(a, b):
    return (b << 4) | a


def get_y(dut):
    return int(dut.uo_out.value) & 0xF


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1

    # Reset
    dut._log.info("Reset")
    dut.ui_in.value = pack_inputs(random.randint(0,15), random.randint(0,15))
    dut.uio_in.value = 0

    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Operation = 0 (default case)
    dut.uio_in.value = 0
    for _ in range(10):
        a = random.randint(0,15)
        b = random.randint(0,15)

        dut.ui_in.value = pack_inputs(a, b)

        await ClockCycles(dut.clk, 1)

        assert get_y(dut) == 0

    # ADD
    dut.uio_in.value = 1
    for _ in range(10):
        a = random.randint(0,15)
        b = random.randint(0,15)

        dut.ui_in.value = pack_inputs(a, b)

        await ClockCycles(dut.clk, 2)

        assert get_y(dut) == ((a + b) & 0xF)

    # SUB
    dut.uio_in.value = 2
    for _ in range(10):
        a = random.randint(0,15)
        b = random.randint(0,15)

        dut.ui_in.value = pack_inputs(a, b)

        await ClockCycles(dut.clk, 2)

        assert get_y(dut) == ((a - b) & 0xF)

    # LOG2
    dut.uio_in.value = 4
    for _ in range(10):
        a = random.randint(1,15)   # avoid log2(0)

        dut.ui_in.value = pack_inputs(a, 0)

        await ClockCycles(dut.clk, 2)

        assert get_y(dut) == int(math.log2(a))

    # SQRT
    dut.uio_in.value = 8
    for _ in range(10):
        a = random.randint(0,15)

        dut.ui_in.value = pack_inputs(a, 0)

        await ClockCycles(dut.clk, 2)

        assert get_y(dut) == round(math.sqrt(a))