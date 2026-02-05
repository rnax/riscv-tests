# See LICENSE for license details.

#*****************************************************************************
# pm2sub_h.S
#-----------------------------------------------------------------------------
#
# Test pm2sub.h instruction (packed 2-way multiply-sub halfword).
# Performs two 16-bit signed multiplies and subtracts results from 32-bit accumulators.
# rd[31:0] = rd[31:0] - sext(rs1[15:0]) * sext(rs2[15:0])
# rd[63:32] = rd[63:32] - sext(rs1[31:16]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-sub: 100 - 3 * 7 = 79 (lower), 200 - 5 * 11 = 145 (upper)
  TEST_CASE( 2, x3, 0x0000004f, \
    li  x3, 0x000000c8; \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm2sub.h x3, x1, x2; \
  )

  # Subtract from existing value: 500 - 5 * 10 = 450 (lower), 600 - 7 * 14 = 502 (upper)
  TEST_CASE( 3, x3, 0x000001f6, \
    li  x3, 0x00000258; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2sub.h x3, x1, x2; \
  )

  # Negative multiply-sub: 500 - (-10) * 20 = 700 (lower), 600 - (-5) * 10 = 650 (upper)
  TEST_CASE( 4, x3, 0x0000028a, \
    li  x3, 0x00000258; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pm2sub.h x3, x1, x2; \
  )

  # Mixed signs: 1000 - (-4) * 6 = 1024 (lower), 2000 - 8 * (-3) = 2024 (upper)
  TEST_CASE( 5, x3, 0x000007e8, \
    li  x3, 0x000007d0; \
    li  x1, 0xfffcfffc; \
    li  x2, 0xfffdfffe; \
    pm2sub.h x3, x1, x2; \
  )

  # Zero multiply-sub: 500 - 0 * 100 = 500 (lower), 600 - 0 * 200 = 600 (upper)
  TEST_CASE( 6, x3, 0x00000258, \
    li  x3, 0x00000258; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2sub.h x3, x1, x2; \
  )

  # Large values: 0x7fffffff - 0x7fff * 0x7fff = 0x40000ffe (lower)
  TEST_CASE( 7, x3, 0x40000ffe, \
    li  x3, 0x7fffffff; \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm2sub.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

