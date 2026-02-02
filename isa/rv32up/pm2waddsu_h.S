# See LICENSE for license details.

#*****************************************************************************
# pm2waddsu_h.S
#-----------------------------------------------------------------------------
#
# Test pm2waddsu.h instruction (packed 2-way signed*unsigned widening multiply-add halfword).
# Performs two 16-bit signed*unsigned multiplies and adds results to 32-bit accumulators.
# rd[31:0] = rd[31:0] + sext(rs1[15:0]) * zext(rs2[15:0])
# rd[63:32] = rd[63:32] + sext(rs1[31:16]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic signed*unsigned multiply-add: 0 + 3 * 7 = 21 (lower), 0 + 5 * 11 = 55 (upper)
  TEST_CASE( 2, x3, 0x00000015, \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm2waddsu.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150 (lower), 200 + 7 * 14 = 298 (upper)
  TEST_CASE( 3, x3, 0x0000012a, \
    li  x3, 0x000000c8; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2waddsu.h x3, x1, x2; \
  )

  # Negative signed * unsigned: 0 + (-10) * 20 = -200 (lower), 0 + (-5) * 10 = -50 (upper)
  TEST_CASE( 4, x3, 0xffffcf38, \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pm2waddsu.h x3, x1, x2; \
  )

  # Mixed signs: 0 + (-4) * 6 = -24 (lower), 0 + 8 * 0xffff = -8 (upper)
  TEST_CASE( 5, x3, 0xfffffff8, \
    li  x1, 0x0008fffc; \
    li  x2, 0xffffffff; \
    pm2waddsu.h x3, x1, x2; \
  )

  # Zero multiply: 500 + 0 * 100 = 500 (lower), 600 + 0 * 200 = 600 (upper)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2waddsu.h x3, x1, x2; \
  )

  # Large values: 0 + 0x7fff * 0xffff = -0x7fff (lower)
  TEST_CASE( 7, x3, 0xffff8001, \
    li  x1, 0x7fff7fff; \
    li  x2, 0xffffffff; \
    pm2waddsu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

