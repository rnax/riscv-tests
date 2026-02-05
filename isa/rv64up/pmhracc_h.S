# See LICENSE for license details.

#*****************************************************************************
# pmhracc_h.S
#-----------------------------------------------------------------------------
#
# Test pmhracc.h instruction (packed multiply high with rounding accumulate halfword).
# Performs two 16-bit signed multiplies with rounding and accumulates high 32-bit results.
# rd[31:0] = rd[31:0] + round((sext(rs1[15:0]) * sext(rs2[15:0])) >> 15)
# rd[63:32] = rd[63:32] + round((sext(rs1[31:16]) * sext(rs2[31:16])) >> 15)
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
    pmhracc.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + round((5 * 10) >> 15) = 100 (lower)
  TEST_CASE( 3, x3, 0x00000064, \
    li  x3, 0x00000064; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pmhracc.h x3, x1, x2; \
  )

  # Larger multiply with rounding: 0 + round((0x1000 * 0x1000) >> 15) = 0 + 0x200 = 0x200 (lower)
  TEST_CASE( 4, x3, 0x00000200, \
    li  x3, 0x00000000; \
    li  x1, 0x10001000; \
    li  x2, 0x10001000; \
    pmhracc.h x3, x1, x2; \
  )

  # Negative multiply: 50 + round(((-10) * 20) >> 15) = 50 + 0xffffffff = 49
  TEST_CASE( 5, x3, 0x00000031, \
    li  x3, 0x00000032; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pmhracc.h x3, x1, x2; \
  )

  # Both negative: 200 + round(((-100) * (-100)) >> 15) = 200 + 0x4e2 = 0x6e2
  TEST_CASE( 6, x3, 0x000006e2, \
    li  x3, 0x000000c8; \
    li  x1, 0xff9cff9c; \
    li  x2, 0xff9cff9c; \
    pmhracc.h x3, x1, x2; \
  )

  # Zero multiply: 500 + round((0 * 100) >> 15) = 500
  TEST_CASE( 7, x3, 0x000001f4, \
    li  x3, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pmhracc.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

