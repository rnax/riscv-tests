# See LICENSE for license details.

#*****************************************************************************
# pasub_db.S
#-----------------------------------------------------------------------------
#
# Test pasub.db instruction (packed averaging subtract double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 - rs2:rs2+1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit averaging subtract: (0x0a0a0a0a0a0a0a0a - 0x0404040404040404) >> 1 = 0x0303030303030303
  TEST_CASE_D32( 2, x14, x15, 0x0303030303030303, \
    li  x10, 0x0a0a0a0a; \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x04040404; \
    li  x13, 0x04040404; \
    pasub.db x14, x10, x12; \
  )

  # Negative numbers: (0xfffffffc - 0x00000006) >> 1 = 0xfffffff3
  TEST_CASE_D32( 3, x14, x15, 0xfffffff3fffffff3, \
    li  x10, 0xfffffffc; \
    li  x11, 0xffffffff; \
    li  x12, 0x00000006; \
    li  x13, 0x00000000; \
    pasub.db x14, x10, x12; \
  )

  # Zero cases: (0x00000000 - 0x00000000) >> 1 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pasub.db x14, x10, x12; \
  )

  # Large positive: (0x7f7f7f7f - 0x01010101) >> 1 = 0x3f3f3f3f
  TEST_CASE_D32( 5, x14, x15, 0x3f3f3f3f3f3f3f3f, \
    li  x10, 0x7f7f7f7f; \
    li  x11, 0x7f7f7f7f; \
    li  x12, 0x01010101; \
    li  x13, 0x01010101; \
    pasub.db x14, x10, x12; \
  )

  # Odd difference: (0x07070707 - 0x04040404) >> 1 = 0x01010101
  TEST_CASE_D32( 6, x14, x15, 0x0101010101010101, \
    li  x10, 0x07070707; \
    li  x11, 0x07070707; \
    li  x12, 0x04040404; \
    li  x13, 0x04040404; \
    pasub.db x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

