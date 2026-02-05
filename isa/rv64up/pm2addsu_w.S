# See LICENSE for license details.

#*****************************************************************************
# pm2addsu_w.S
#-----------------------------------------------------------------------------
#
# Test pm2addsu.w instruction (packed 2-way signed*unsigned multiply-add word).
# Performs two 32-bit signed*unsigned multiplies and adds results to 64-bit accumulators.
# rd[63:0] = rd[63:0] + sext(rs1[31:0]) * zext(rs2[31:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic signed*unsigned multiply-add: 0 + 3 * 7 = 21
  TEST_CASE( 2, x3, 0x0000000000000015, \
    li  x1, 0x0000000000000003; \
    li  x2, 0x0000000000000007; \
    pm2addsu.w x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000000000000000a; \
    pm2addsu.w x3, x1, x2; \
  )

  # Negative signed with unsigned: 0 + (-10) * 20 = -200
  TEST_CASE( 4, x3, 0xffffffffffffff38, \
    li  x1, 0xfffffffffffffff6; \
    li  x2, 0x0000000000000014; \
    pm2addsu.w x3, x1, x2; \
  )

  # Mixed: 0 + (-4) * 6 = -24
  TEST_CASE( 5, x3, 0xffffffffffffffe8, \
    li  x1, 0xfffffffffffffffc; \
    li  x2, 0x0000000000000006; \
    pm2addsu.w x3, x1, x2; \
  )

  # Zero multiply: 0 + 0 * 100 = 0
  TEST_CASE( 6, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000000064; \
    pm2addsu.w x3, x1, x2; \
  )

  # Large values: 0 + 0x7fffffff * 0xffffffff = 0x7ffffffe80000001
  TEST_CASE( 7, x3, 0x7ffffffe80000001, \
    li  x1, 0x000000007fffffff; \
    li  x2, 0x00000000ffffffff; \
    pm2addsu.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

