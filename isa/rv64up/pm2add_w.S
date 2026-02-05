# See LICENSE for license details.

#*****************************************************************************
# pm2add_w.S
#-----------------------------------------------------------------------------
#
# Test pm2add.w instruction (packed 2-way multiply-add word).
# Performs two 32-bit signed multiplies and adds results to 64-bit accumulators.
# rd[63:0] = rd[63:0] + sext(rs1[31:0]) * sext(rs2[31:0])
# Note: This is a 2-way operation on 64-bit register (one 32-bit multiply per half)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-add: 0 + 3 * 7 = 21
  TEST_CASE( 2, x3, 0x0000000000000015, \
    li  x1, 0x0000000000000003; \
    li  x2, 0x0000000000000007; \
    pm2add.w x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000000000000000a; \
    pm2add.w x3, x1, x2; \
  )

  # Negative multiply: 0 + (-10) * 20 = -200
  TEST_CASE( 4, x3, 0xffffffffffffff38, \
    li  x1, 0xfffffffffffffff6; \
    li  x2, 0x0000000000000014; \
    pm2add.w x3, x1, x2; \
  )

  # Mixed signs: 0 + (-4) * 6 = -24
  TEST_CASE( 5, x3, 0xffffffffffffffe8, \
    li  x1, 0xfffffffffffffffc; \
    li  x2, 0x0000000000000006; \
    pm2add.w x3, x1, x2; \
  )

  # Zero multiply: 0 + 0 * 100 = 0
  TEST_CASE( 6, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000000064; \
    pm2add.w x3, x1, x2; \
  )

  # Large values: 0 + 0x7fffffff * 0x7fffffff = 0x3fffffff00000001
  TEST_CASE( 7, x3, 0x3fffffff00000001, \
    li  x1, 0x000000007fffffff; \
    li  x2, 0x000000007fffffff; \
    pm2add.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

