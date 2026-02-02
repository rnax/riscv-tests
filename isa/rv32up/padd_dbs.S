# See LICENSE for license details.

#*****************************************************************************
# padd_dbs.S
#-----------------------------------------------------------------------------
#
# Test padd.dbs instruction (packed add double-byte saturating).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 + rs2:rs2+1 (saturated)
# 8 elements of 8-bits each, signed saturating add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 4 + 6 = 10 for each byte
  TEST_CASE_D32( 2, x14, x15, 0x0a0a0a0a0a0a0a0a, \
    li  x11, 0x04040404; \
    li  x12, 0x00000000; \
    li  x13, 0x06060606; \
    li  x16, 0x00000000; \
    padd.dbs x14, x11, x13; \
  )

  # Positive saturation: 100 + 100 = 200 (saturates to 127 in signed 8-bit)
  TEST_CASE_D32( 3, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    li  x11, 0x64646464; \
    li  x12, 0x00000000; \
    li  x13, 0x64646464; \
    li  x16, 0x00000000; \
    padd.dbs x14, x11, x13; \
  )

  # Negative saturation: -100 + -100 = -200 (saturates to -128 in signed 8-bit)
  TEST_CASE_D32( 4, x14, x15, 0x8080808080808080, \
    li  x11, 0x9c9c9c9c; \
    li  x12, 0xffffffff; \
    li  x13, 0x9c9c9c9c; \
    li  x16, 0xffffffff; \
    padd.dbs x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    padd.dbs x14, x11, x13; \
  )

  # No saturation: 50 + 50 = 100 for each byte
  TEST_CASE_D32( 6, x14, x15, 0x6464646464646464, \
    li  x11, 0x32323232; \
    li  x12, 0x00000000; \
    li  x13, 0x32323232; \
    li  x16, 0x00000000; \
    padd.dbs x14, x11, x13; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x0a0a0a0a0a0a0a0a, \
    li  x10, 0x04040404; \
    li  x11, 0x00000000; \
    li  x12, 0x06060606; \
    li  x13, 0x00000000; \
    padd.dbs x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

