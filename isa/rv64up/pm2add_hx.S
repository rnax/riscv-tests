# See LICENSE for license details.

#*****************************************************************************
# pm2add_hx.S
#-----------------------------------------------------------------------------
#
# Test pm2add.hx instruction (packed 2-way multiply-add halfword cross).
# Performs cross multiply-add: lower*upper and upper*lower.
# rd[31:0] = rd[31:0] + sext(rs1[15:0]) * sext(rs2[31:16])
# rd[63:32] = rd[63:32] + sext(rs1[31:16]) * sext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross multiply-add: 0 + 3 * 11 = 33 (lower), 0 + 5 * 7 = 35 (upper)
  TEST_CASE( 2, x3, 0x00000021, \
    li  x1, 0x00050003; \
    li  x2, 0x0007000b; \
    pm2add.hx x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 14 = 170 (lower), 200 + 7 * 10 = 270 (upper)
  TEST_CASE( 3, x3, 0x0000010e, \
    li  x3, 0x000000c8; \
    li  x1, 0x00070005; \
    li  x2, 0x000a000e; \
    pm2add.hx x3, x1, x2; \
  )

  # Negative cross multiply: 0 + (-10) * 10 = -100 (lower), 0 + (-5) * 20 = -100 (upper)
  TEST_CASE( 4, x3, 0xffffff9c, \
    li  x1, 0xfffbfff6; \
    li  x2, 0x0014000a; \
    pm2add.hx x3, x1, x2; \
  )

  # Mixed signs: 0 + (-4) * (-3) = 12 (lower), 0 + 8 * 6 = 48 (upper)
  TEST_CASE( 5, x3, 0x0000003c, \
    li  x1, 0x0008fffc; \
    li  x2, 0xfffdfffe; \
    pm2add.hx x3, x1, x2; \
  )

  # Zero cross multiply: 0 + 0 * 100 = 0 (lower), 0 + 0 * 200 = 0 (upper)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2add.hx x3, x1, x2; \
  )

  # Large cross values: 0 + 0x7fff * 0x7fff = 0x3fff0001 (lower)
  TEST_CASE( 7, x3, 0x3fff0001, \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm2add.hx x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

