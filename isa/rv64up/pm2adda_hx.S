# See LICENSE for license details.

#*****************************************************************************
# pm2adda_hx.S
#-----------------------------------------------------------------------------
#
# Test pm2adda.hx instruction (packed 2-way multiply-add accumulate halfword cross).
# Performs cross multiply-add with accumulation.
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

  # Basic cross accumulate: 100 + 3 * 11 = 133 (lower), 200 + 5 * 7 = 235 (upper)
  TEST_CASE( 2, x3, 0x000000eb, \
    li  x3, 0x000000c8; \
    li  x1, 0x00050003; \
    li  x2, 0x0007000b; \
    pm2adda.hx x3, x1, x2; \
  )

  # Multiple cross accumulations: 50 + 5 * 14 = 120 (lower), 75 + 7 * 10 = 145 (upper)
  TEST_CASE( 3, x3, 0x00000091, \
    li  x3, 0x0000004b; \
    li  x1, 0x00070005; \
    li  x2, 0x000a000e; \
    pm2adda.hx x3, x1, x2; \
  )

  # Negative cross accumulate: 500 + (-10) * 10 = 400 (lower), 600 + (-5) * 20 = 500 (upper)
  TEST_CASE( 4, x3, 0x000001f4, \
    li  x3, 0x00000258; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x0014000a; \
    pm2adda.hx x3, x1, x2; \
  )

  # Mixed signs cross accumulate: 1000 + (-4) * (-3) = 1012 (lower), 2000 + 8 * 6 = 2048 (upper)
  TEST_CASE( 5, x3, 0x00000800, \
    li  x3, 0x000007d0; \
    li  x1, 0x0008fffc; \
    li  x2, 0xfffdfffe; \
    pm2adda.hx x3, x1, x2; \
  )

  # Zero cross accumulate: 500 + 0 * 100 = 500 (lower), 600 + 0 * 200 = 600 (upper)
  TEST_CASE( 6, x3, 0x00000258, \
    li  x3, 0x00000258; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2adda.hx x3, x1, x2; \
  )

  # Large cross accumulate: 1000 + 0x7fff * 0x7fff = 0x3fff1001 (lower)
  TEST_CASE( 7, x3, 0x3fff1001, \
    li  x3, 0x000003e8; \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm2adda.hx x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

