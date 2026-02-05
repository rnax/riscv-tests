# See LICENSE for license details.

#*****************************************************************************
# pmqr2add_h.S
#-----------------------------------------------------------------------------
#
# Test pmqr2add.h instruction (packed Q-format 2-way multiply-add with rounding halfword).
# Performs two 16-bit Q-format multiplies with rounding and adds results to 32-bit accumulators.
# rd[31:0] = round((sext(rs1[15:0]) * sext(rs2[15:0])) >> 14)
# rd[63:32] = round((sext(rs1[31:16]) * sext(rs2[31:16])) >> 14)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply with rounding: round((0.5 * 0.5) >> 14) = 0.5
  # round((0x4000 * 0x4000) >> 14) = 0x8000
  TEST_CASE( 2, x3, 0x00008000, \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqr2add.h x3, x1, x2; \
  )

  # Negative Q-format: round((-0.5 * 0.5) >> 14) = -0.5
  # round((0xC000 * 0x4000) >> 14) = 0xFFFF8000
  TEST_CASE( 3, x3, 0xffff8000, \
    li  x1, 0xC000C000; \
    li  x2, 0x40004000; \
    pmqr2add.h x3, x1, x2; \
  )

  # Both negative: round((-0.5 * -0.5) >> 14) = 0.5
  # round((0xC000 * 0xC000) >> 14) = 0x8000
  TEST_CASE( 4, x3, 0x00008000, \
    li  x1, 0xC000C000; \
    li  x2, 0xC000C000; \
    pmqr2add.h x3, x1, x2; \
  )

  # Small values: round((0.1 * 0.1) >> 14) ≈ 0.01
  # round((0x0CCD * 0x0CCD) >> 14) ≈ 0x020C
  TEST_CASE( 5, x3, 0x0000020c, \
    li  x1, 0x0CCD0CCD; \
    li  x2, 0x0CCD0CCD; \
    pmqr2add.h x3, x1, x2; \
  )

  # Zero multiply: round((0 * 0.5) >> 14) = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x40004000; \
    pmqr2add.h x3, x1, x2; \
  )

  # One (Q15: 0x7FFF) * 0.5 = 0.5
  # round((0x7FFF * 0x4000) >> 14) = 0x7FFF
  TEST_CASE( 7, x3, 0x00007fff, \
    li  x1, 0x7FFF7FFF; \
    li  x2, 0x40004000; \
    pmqr2add.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

