# See LICENSE for license details.

#*****************************************************************************
# pmqr2adda_h.S
#-----------------------------------------------------------------------------
#
# Test pmqr2adda.h instruction (packed Q-format 2-way multiply-add with rounding accumulate halfword).
# Performs two 16-bit Q-format multiplies with rounding and accumulates results to 32-bit accumulators.
# rd[31:0] = rd[31:0] + round((sext(rs1[15:0]) * sext(rs2[15:0])) >> 14)
# rd[63:32] = rd[63:32] + round((sext(rs1[31:16]) * sext(rs2[31:16])) >> 14)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply-accumulate with rounding: 0 + round((0.5 * 0.5) >> 14) = 0.5
  # 0 + round((0x4000 * 0x4000) >> 14) = 0x8000
  TEST_CASE( 2, x3, 0x00008000, \
    li  x3, 0x00000000; \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqr2adda.h x3, x1, x2; \
  )

  # Accumulate to existing value: 0x1000 + round((0.5 * 0.5) >> 14) = 0x9000
  TEST_CASE( 3, x3, 0x00009000, \
    li  x3, 0x00001000; \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqr2adda.h x3, x1, x2; \
  )

  # Negative Q-format: 0 + round((-0.5 * 0.5) >> 14) = -0.5
  # 0 + round((0xC000 * 0x4000) >> 14) = 0xFFFF8000
  TEST_CASE( 4, x3, 0xffff8000, \
    li  x3, 0x00000000; \
    li  x1, 0xC000C000; \
    li  x2, 0x40004000; \
    pmqr2adda.h x3, x1, x2; \
  )

  # Both negative: 0 + round((-0.5 * -0.5) >> 14) = 0.5
  # 0 + round((0xC000 * 0xC000) >> 14) = 0x8000
  TEST_CASE( 5, x3, 0x00008000, \
    li  x3, 0x00000000; \
    li  x1, 0xC000C000; \
    li  x2, 0xC000C000; \
    pmqr2adda.h x3, x1, x2; \
  )

  # Zero multiply: 500 + round((0 * 0.5) >> 14) = 500
  TEST_CASE( 6, x3, 0x000001f4, \
    li  x3, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x40004000; \
    pmqr2adda.h x3, x1, x2; \
  )

  # One (Q15: 0x7FFF) * 0.5 = 0.5
  # 100 + round((0x7FFF * 0x4000) >> 14) = 100 + 0x7FFF = 0x807F
  TEST_CASE( 7, x3, 0x0000807f, \
    li  x3, 0x00000064; \
    li  x1, 0x7FFF7FFF; \
    li  x2, 0x40004000; \
    pmqr2adda.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

