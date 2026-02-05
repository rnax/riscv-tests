# See LICENSE for license details.

#*****************************************************************************
# pmhraccsu_h.S
#-----------------------------------------------------------------------------
#
# Test pmhraccsu.h instruction (packed multiply high with rounding accumulate signed*unsigned).
# Performs two 16-bit signed*unsigned multiplies with rounding and accumulates high 32-bit results.
# rd[31:0] = rd[31:0] + round((sext(rs1[15:0]) * zext(rs2[15:0])) >> 15)
# rd[63:32] = rd[63:32] + round((sext(rs1[31:16]) * zext(rs2[31:16])) >> 15)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + round((3 * 7) >> 15) = 0 (lower)
  TEST_CASE( 2, x3, 0x00000000, \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pmhraccsu.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + round((5 * 10) >> 15) = 100 (lower)
  TEST_CASE( 3, x3, 0x00000064, \
    li  x3, 0x00000064; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pmhraccsu.h x3, x1, x2; \
  )

  # Signed negative, unsigned positive: 0 + round(((-10) * 20) >> 15) = 0xffffffff (lower)
  TEST_CASE( 4, x3, 0xffffffff, \
    li  x3, 0x00000000; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pmhraccsu.h x3, x1, x2; \
  )

  # Mixed signs: 0 + round(((-4) * 6) >> 15) = 0xffffffff (lower)
  TEST_CASE( 5, x3, 0xffffffff, \
    li  x3, 0x00000000; \
    li  x1, 0xfffcfffc; \
    li  x2, 0x00060006; \
    pmhraccsu.h x3, x1, x2; \
  )

  # Positive signed, positive unsigned: 0 + round((100 * 100) >> 15) = 0 (lower)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00640064; \
    li  x2, 0x00640064; \
    pmhraccsu.h x3, x1, x2; \
  )

  # Zero multiply: 500 + round((0 * 100) >> 15) = 500 (lower)
  TEST_CASE( 7, x3, 0x000001f4, \
    li  x3, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pmhraccsu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

