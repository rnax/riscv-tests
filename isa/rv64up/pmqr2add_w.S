# See LICENSE for license details.

#*****************************************************************************
# pmqr2add_w.S
#-----------------------------------------------------------------------------
#
# Test pmqr2add.w instruction (packed Q-format 2-way multiply-add with rounding word).
# Performs two 32-bit Q-format multiplies with rounding and adds results to 64-bit accumulators.
# rd[31:0] = round((sext(rs1[31:0]) * sext(rs2[31:0])) >> 30)
# rd[63:32] = round((sext(rs1[63:32]) * sext(rs2[63:32])) >> 30)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply with rounding: round((0.5 * 0.5) >> 30) = 0.5
  # round((0x40000000 * 0x40000000) >> 30) = 0x40000000
  TEST_CASE( 2, x3, 0x0000000040000000, \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqr2add.w x3, x1, x2; \
  )

  # Negative Q-format: round((-0.5 * 0.5) >> 30) = -0.5
  # round((0xC0000000 * 0x40000000) >> 30) = 0xFFFFFFFFC0000000
  TEST_CASE( 3, x3, 0xffffffffc0000000, \
    li  x1, 0xc000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqr2add.w x3, x1, x2; \
  )

  # Both negative: round((-0.5 * -0.5) >> 30) = 0.5
  # round((0xC0000000 * 0xC0000000) >> 30) = 0x40000000
  TEST_CASE( 4, x3, 0x0000000040000000, \
    li  x1, 0xc000000040000000; \
    li  x2, 0xc000000040000000; \
    pmqr2add.w x3, x1, x2; \
  )

  # Small values: round((0.1 * 0.1) >> 30) ≈ 0.01
  # round((0x0CCD0CCD * 0x0CCD0CCD) >> 30) ≈ 0x020C
  TEST_CASE( 5, x3, 0x000000000000020c, \
    li  x1, 0x0ccd0ccd0ccd0ccd; \
    li  x2, 0x0ccd0ccd0ccd0ccd; \
    pmqr2add.w x3, x1, x2; \
  )

  # Zero multiply: round((0 * 0.5) >> 30) = 0
  TEST_CASE( 6, x3, 0x0000000000000000, \
    li  x1, 0x0000000000000000; \
    li  x2, 0x4000000040000000; \
    pmqr2add.w x3, x1, x2; \
  )

  # One (Q31: 0x7FFFFFFF) * 0.5 = 0.5
  # round((0x7FFFFFFF * 0x40000000) >> 30) = 0x7FFFFFFF
  TEST_CASE( 7, x3, 0x000000007fffffff, \
    li  x1, 0x7fffffff7fffffff; \
    li  x2, 0x4000000040000000; \
    pmqr2add.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

