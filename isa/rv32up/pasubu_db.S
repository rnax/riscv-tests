# See LICENSE for license details.

#*****************************************************************************
# pasubu_db.S
#-----------------------------------------------------------------------------
#
# Test pasubu_db instruction (packed unsigned averaging subtract double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 - rs2:rs2+1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit unsigned averaging subtract: (0x0a0a0a0a - 0x04040404) >> 1 = 0x03030303
  TEST_CASE_D32( 2, x14, x15, 0x0303030303030303, \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x0a0a0a0a; \
    li  x13, 0x04040404; \
    li  x16, 0x04040404; \
    pasubu_db x14, x11, x13; \
  )

  # Large unsigned values: (0xffffffff - 0x00000001) >> 1 = 0x7fffffff
  TEST_CASE_D32( 3, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x01010101; \
    li  x16, 0x01010101; \
    pasubu_db x14, x11, x13; \
  )

  # Zero cases: (0x00000000 - 0x00000000) >> 1 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pasubu_db x14, x11, x13; \
  )

  # Odd difference: (0x0f0f0f0f - 0x0a0a0a0a) >> 1 = 0x02020202
  TEST_CASE_D32( 5, x14, x15, 0x0202020202020202, \
    li  x11, 0x0f0f0f0f; \
    li  x12, 0x0f0f0f0f; \
    li  x13, 0x0a0a0a0a; \
    li  x16, 0x0a0a0a0a; \
    pasubu_db x14, x11, x13; \
  )

  # Same values: (0xaa - 0xaa) >> 1 = 0x00
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    li  x16, 0xaaaaaaaa; \
    pasubu_db x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

