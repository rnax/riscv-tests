# See LICENSE for license details.

#*****************************************************************************
# psadd_db.S
#-----------------------------------------------------------------------------
#
# Test psadd.db instruction (packed saturating add double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 + rs2:rs2+1)
# 8 elements of 8-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 10 + 20 = 30 for each byte
  TEST_CASE_D32( 2, x14, x15, 0x1e1e1e1e1e1e1e1e, \
    li  x10, 0x0a0a0a0a; \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x14141414; \
    li  x13, 0x14141414; \
    psadd.db x14, x10, x12; \
  )

  # Saturation at max positive: 100 + 100 = 200 (saturates to 127)
  TEST_CASE_D32( 3, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    li  x10, 0x64646464; \
    li  x11, 0x64646464; \
    li  x12, 0x64646464; \
    li  x13, 0x64646464; \
    psadd.db x14, x10, x12; \
  )

  # Saturation at min negative: -100 + -100 = -200 (saturates to -128)
  TEST_CASE_D32( 4, x14, x15, 0x8080808080808080, \
    li  x10, 0x9c9c9c9c; \
    li  x11, 0x9c9c9c9c; \
    li  x12, 0x9c9c9c9c; \
    li  x13, 0x9c9c9c9c; \
    psadd.db x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    psadd.db x14, x10, x12; \
  )

  # Mixed values: 50 + 30 = 80
  TEST_CASE_D32( 6, x14, x15, 0x5050505050505050, \
    li  x10, 0x32323232; \
    li  x11, 0x32323232; \
    li  x12, 0x1e1e1e1e; \
    li  x13, 0x1e1e1e1e; \
    psadd.db x14, x10, x12; \
  )

  # Negative operands: -10 + -20 = -30
  TEST_CASE_D32( 7, x14, x15, 0xe2e2e2e2e2e2e2e2, \
    li  x10, 0xf6f6f6f6; \
    li  x11, 0xf6f6f6f6; \
    li  x12, 0xececec; \
    li  x13, 0xececec; \
    psadd.db x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

