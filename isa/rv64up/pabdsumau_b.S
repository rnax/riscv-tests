# See LICENSE for license details.

#*****************************************************************************
# pabdsumau_b.S
#-----------------------------------------------------------------------------
#
# Test pabdsumau.b instruction (packed unsigned absolute difference sum accumulate byte).
# Operates on 32-bit register: rd = rd + sum(|rs1 - rs2|) for all byte elements
# 4 elements of 8-bits each, summed and accumulated
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Accumulate zero: 0 + sum(|0 - 0|) = 0
  TEST_CASE( 2, x14, 0x00000000, \
    li  x14, 0x00000000; \
    li  x11, 0x00000000; \
    li  x13, 0x00000000; \
    pabdsumau.b x14, x11, x13; \
  )

  # Accumulate with initial value: 10 + sum(|5 - 5|) = 10
  TEST_CASE( 3, x14, 0x0000000a, \
    li  x14, 0x0000000a; \
    li  x11, 0x05050505; \
    li  x13, 0x05050505; \
    pabdsumau.b x14, x11, x13; \
  )

  # Simple accumulate: 5 + sum(|10 - 4|) = 5 + 24 = 29
  TEST_CASE( 4, x14, 0x0000001d, \
    li  x14, 0x00000005; \
    li  x11, 0x0a0a0a0a; \
    li  x13, 0x04040404; \
    pabdsumau.b x14, x11, x13; \
  )

  # Accumulate mixed: 100 + sum(|10 - 4|) = 100 + 24 = 124
  TEST_CASE( 5, x14, 0x0000007c, \
    li  x14, 0x00000064; \
    li  x11, 0x0a0a0a0a; \
    li  x13, 0x04040404; \
    pabdsumau.b x14, x11, x13; \
  )

  # Accumulate large: 500 + sum(|255 - 0|) = 500 + 1020 = 1520
  TEST_CASE( 6, x14, 0x000005f0, \
    li  x14, 0x000001f4; \
    li  x11, 0xffffffff; \
    li  x13, 0x00000000; \
    pabdsumau.b x14, x11, x13; \
  )

  # Accumulate with overflow: 1000 + sum(|100 - 50|) = 1000 + 200 = 1200
  TEST_CASE( 7, x14, 0x000004b0, \
    li  x14, 0x000003e8; \
    li  x11, 0x64646464; \
    li  x13, 0x32323232; \
    pabdsumau.b x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

