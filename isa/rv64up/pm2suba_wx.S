# See LICENSE for license details.

#*****************************************************************************
# pm2suba_wx.S
#-----------------------------------------------------------------------------
#
# Test pm2suba.wx instruction (packed 2-way multiply-sub accumulate word cross).
# Performs cross multiply-sub on 32-bit elements with saturation.
# rd[63:0] = sat(rd[63:0] - sext(rs1[31:0]) * sext(rs2[63:32]))
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross multiply-sub: 0 - 3 * 11 = -33
  TEST_CASE( 2, x3, 0xffffffffffffffdf, \
    li  x1, 0x0000000000000003; \
    li  x2, 0x000000000b000000; \
    pm2suba.wx x3, x1, x2; \
  )

  # Subtract from existing value: 100 - 5 * 14 = 30
  TEST_CASE( 3, x3, 0x000000000000001e, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000e000000000000; \
    pm2suba.wx x3, x1, x2; \
  )

  # Negative cross multiply: 0 - (-10) * 10 = 100
  TEST_CASE( 4, x3, 0x0000000000000064, \
    li  x1, 0xfffffffffffffff6; \
    li  x2, 0x000a000000000000; \
    pm2suba.wx x3, x1, x2; \
  )

  # Mixed signs: 0 - (-4) * (-3) = -12
  TEST_CASE( 5, x3, 0xfffffffffffffff4, \
    li  x1, 0xfffffffffffffffc; \
    li  x2, 0xfffffffd00000000; \
    pm2suba.wx x3, x1, x2; \
  )

  # Zero cross multiply: 0 - 0 * 100 = 0
  TEST_CASE( 6, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000064000000; \
    pm2suba.wx x3, x1, x2; \
  )

  # Large cross values: 0 - 0x7fffffff * 0x7fffffff = -0x3fffffff00000001
  TEST_CASE( 7, x3, 0xc000000fffffffff, \
    li  x1, 0x000000007fffffff; \
    li  x2, 0x7fffffff00000000; \
    pm2suba.wx x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

