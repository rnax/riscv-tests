# See LICENSE for license details.

#*****************************************************************************
# mqacc_w11.S
#-----------------------------------------------------------------------------
#
# Test mqacc.w11 instruction (Q-format multiply-accumulate word top-top).
# Performs 32-bit signed Q-format multiply on upper words and accumulates result.
# rd = rd + (sext(rs1[63:32]) * sext(rs2[63:32])) >> 31
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply: 0 + (0.5 * 0.5) = 0.25
  # 0 + (0x40000000 * 0x40000000 >> 31) = 0x20000000
  TEST_CASE( 2, x3, 0x0000000020000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x4000000000000000; \
    li  x2, 0x4000000000000000; \
    mqacc.w11 x3, x1, x2; \
  )

  # Accumulate to existing value: 0x10000000 + (0.5 * 0.5) = 0x30000000
  TEST_CASE( 3, x3, 0x0000000030000000, \
    li  x3, 0x0000000010000000; \
    li  x1, 0x4000000000000000; \
    li  x2, 0x4000000000000000; \
    mqacc.w11 x3, x1, x2; \
  )

  # Negative Q-format: 0 + (-0.5 * 0.5) = -0.25
  # 0 + (0xc0000000 * 0x40000000 >> 31) = 0xe0000000
  TEST_CASE( 4, x3, 0xffffffffe0000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000000000000; \
    li  x2, 0x4000000000000000; \
    mqacc.w11 x3, x1, x2; \
  )

  # Both negative: 0 + (-0.5 * -0.5) = 0.25
  # 0 + (0xc0000000 * 0xc0000000 >> 31) = 0x20000000
  TEST_CASE( 5, x3, 0x0000000020000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000000000000; \
    li  x2, 0xc000000000000000; \
    mqacc.w11 x3, x1, x2; \
  )

  # One (Q31: 0x7fffffff) * 0.5 = 0.5
  # 0 + (0x7fffffff * 0x40000000 >> 31) = 0x3fffffff
  TEST_CASE( 6, x3, 0x000000003fffffff, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x7fffffff00000000; \
    li  x2, 0x4000000000000000; \
    mqacc.w11 x3, x1, x2; \
  )

  # Zero multiply: 0x100 + (0 * 0.5) = 0x100
  TEST_CASE( 7, x3, 0x0000000000000100, \
    li  x3, 0x0000000000000100; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x4000000000000000; \
    mqacc.w11 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

