# See LICENSE for license details.

#*****************************************************************************
# paadd_db.S
#-----------------------------------------------------------------------------
#
# Test paadd.db instruction (packed averaging add double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 + rs2:rs2+1) >> 1
# 8 elements of 8-bits each, signed averaging add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (4 + 6) >> 1 = 5 for each byte
  TEST_CASE_D32( 2, x14, x15, 0x0505050505050505, \
    li  x11, 0x04040404; \
    li  x12, 0x00000000; \
    li  x13, 0x06060606; \
    li  x16, 0x00000000; \
    paadd.db x14, x11, x13; \
  )

  # Odd sum truncation: (3 + 4) >> 1 = 3 for each byte
  TEST_CASE_D32( 3, x14, x15, 0x0303030303030303, \
    li  x11, 0x03030303; \
    li  x12, 0x00000000; \
    li  x13, 0x04040404; \
    li  x16, 0x00000000; \
    paadd.db x14, x11, x13; \
  )

  # Negative numbers: (-4 + 6) >> 1 = 1 for each byte
  TEST_CASE_D32( 4, x14, x15, 0x0101010101010101, \
    li  x11, 0xfcfcfcfc; \
    li  x12, 0xffffffff; \
    li  x13, 0x06060606; \
    li  x16, 0x00000000; \
    paadd.db x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    paadd.db x14, x11, x13; \
  )

  # Large values: (127 + 127) >> 1 = 127 for each byte
  TEST_CASE_D32( 6, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    li  x11, 0x7f7f7f7f; \
    li  x12, 0x00000000; \
    li  x13, 0x7f7f7f7f; \
    li  x16, 0x00000000; \
    paadd.db x14, x11, x13; \
  )

  # Mixed values across register pair
  TEST_CASE_D32( 7, x10, x11, 0x0a0a0a0a05050505, \
    li  x10, 0x08080808; \
    li  x11, 0x00000000; \
    li  x12, 0x0c0c0c0c; \
    li  x13, 0x00000000; \
    paadd.db x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

