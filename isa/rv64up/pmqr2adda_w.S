# See LICENSE for license details.

#*****************************************************************************
# pmqr2adda_w.S
#-----------------------------------------------------------------------------
#
# Test pmqr2adda.w instruction (packed Q-format 2-way multiply-add with rounding accumulate word).
# Performs two 32-bit Q-format multiplies with rounding and accumulates results to 64-bit accumulators.
# rd[31:0] = rd[31:0] + round((sext(rs1[31:0]) * sext(rs2[31:0])) >> 30)
# rd[63:32] = rd[63:32] + round((sext(rs1[63:32]) * sext(rs2[63:32])) >> 30)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply-accumulate with rounding: 0 + round((0.5 * 0.5) >> 30) = 0.5
  # 0 + round((0x40000000 * 0x40000000) >> 30) = 0x40000000
  TEST_CASE( 2, x3, 0x0000000040000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqr2adda.w x3, x1, x2; \
  )

  # Accumulate to existing value: 0x10000000 + round((0.5 * 0.5) >> 30) = 0x50000000
  TEST_CASE( 3, x3, 0x0000000050000000, \
    li  x3, 0x0000000010000000; \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqr2adda.w x3, x1, x2; \
  )

  # Negative Q-format: 0 + round((-0.5 * 0.5) >> 30) = -0.5
  # 0 + round((0xC0000000 * 0x40000000) >> 30) = 0xFFFFFFFFC0000000
  TEST_CASE( 4, x3, 0xffffffffc0000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqr2adda.w x3, x1, x2; \
  )

  # Both negative: 0 + round((-0.5 * -0.5) >> 30) = 0.5
  # 0 + round((0xC0000000 * 0xC0000000) >> 30) = 0x40000000
  TEST_CASE( 5, x3, 0x0000000040000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000040000000; \
    li  x2, 0xc000000040000000; \
    pmqr2adda.w x3, x1, x2; \
  )

  # Zero multiply: 0x100 + round((0 * 0.5) >> 30) = 0x100
  TEST_CASE( 6, x3, 0x0000000000000100, \
    li  x3, 0x0000000000000100; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x4000000040000000; \
    pmqr2adda.w x3, x1, x2; \
  )

  # One (Q31: 0x7FFFFFFF) * 0.5 = 0.5
  # 0x100 + round((0x7FFFFFFF * 0x40000000) >> 30) = 0x100 + 0x7FFFFFFF = 0x800000FF
  TEST_CASE( 7, x3, 0x00000000800000ff, \
    li  x3, 0x0000000000000100; \
    li  x1, 0x7fffffff7fffffff; \
    li  x2, 0x4000000040000000; \
    pmqr2adda.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

