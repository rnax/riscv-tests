# See LICENSE for license details.

#*****************************************************************************
# padd_db.S
#-----------------------------------------------------------------------------
#
# Test padd.db instruction (packed add double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 + rs2:rs2+1
# 8 elements of 8-bits each, wrapping add
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
    li  x10, 0x04040404; \
    li  x11, 0x00000000; \
    li  x12, 0x06060606; \
    li  x13, 0x00000000; \
    padd.db x14, x10, x12; \
  )

  # Wrapping add: 200 + 100 = 300 (wraps to 44 in 8-bit)
  TEST_CASE_D32( 3, x14, x15, 0x2c2c2c2c2c2c2c2c, \
    li  x10, 0xc8c8c8c8; \
    li  x11, 0x00000000; \
    li  x12, 0x64646464; \
    li  x13, 0x00000000; \
    padd.db x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    padd.db x14, x10, x12; \
  )

  # Large values: 255 + 1 = 256 (wraps to 0 in 8-bit)
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0x01010101; \
    li  x13, 0x00000000; \
    padd.db x14, x10, x12; \
  )

  # Mixed values: 100 + 50 = 150 for each byte
  TEST_CASE_D32( 6, x14, x15, 0x9696969696969696, \
    li  x10, 0x64646464; \
    li  x11, 0x00000000; \
    li  x12, 0x32323232; \
    li  x13, 0x00000000; \
    padd.db x14, x10, x12; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x0a0a0a0a0a0a0a0a, \
    li  x10, 0x04040404; \
    li  x10, 0x00000000; \
    li  x11, 0x06060606; \
    li  x12, 0x00000000; \
    padd.db x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

