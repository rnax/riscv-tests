# See LICENSE for license details.

#*****************************************************************************
# pm2suba_hx.S
#-----------------------------------------------------------------------------
#
# Test pm2suba.hx instruction (packed 2-way multiply-sub accumulate halfword cross).
# Performs cross multiply-sub with accumulation.
# rd[31:0] = rd[31:0] - sext(rs1[15:0]) * sext(rs2[31:16])
# rd[63:32] = rd[63:32] - sext(rs1[31:16]) * sext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross multiply-sub accumulate: 100 - 3 * 11 = 67 (lower), 200 - 5 * 7 = 165 (upper)
  TEST_CASE( 2, x3, 0x000000a5, \
    li  x3, 0x000000c8; \
    li  x1, 0x00050003; \
    li  x2, 0x0007000b; \
    pm2suba.hx x3, x1, x2; \
  )

  # Multiple cross subtract accumulations: 500 - 5 * 14 = 430 (lower), 600 - 7 * 10 = 530 (upper)
  TEST_CASE( 3, x3, 0x00000212, \
    li  x3, 0x00000258; \
    li  x1, 0x00070005; \
    li  x2, 0x000a000e; \
    pm2suba.hx x3, x1, x2; \
  )

  # Negative cross multiply-sub accumulate: 1000 - (-10) * 10 = 1100 (lower), 2000 - (-5) * 20 = 2100 (upper)
  TEST_CASE( 4, x3, 0x00000834, \
    li  x3, 0x000007d0; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x0014000a; \
    pm2suba.hx x3, x1, x2; \
  )

  # Mixed signs cross accumulate: 1000 - (-4) * (-3) = 988 (lower), 2000 - 8 * 6 = 1952 (upper)
  TEST_CASE( 5, x3, 0x000007a0, \
    li  x3, 0x000007d0; \
    li  x1, 0x0008fffc; \
    li  x2, 0xfffdfffe; \
    pm2suba.hx x3, x1, x2; \
  )

  # Zero cross multiply-sub accumulate: 500 - 0 * 100 = 500 (lower), 600 - 0 * 200 = 600 (upper)
  TEST_CASE( 6, x3, 0x00000258, \
    li  x3, 0x00000258; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2suba.hx x3, x1, x2; \
  )

  # Large cross accumulate: 0x7fffffff - 0x7fff * 0x7fff = 0x40000ffe (lower)
  TEST_CASE( 7, x3, 0x40000ffe, \
    li  x3, 0x7fffffff; \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm2suba.hx x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

