# See LICENSE for license details.

#*****************************************************************************
# pmhacc_h.S
#-----------------------------------------------------------------------------
#
# Test pmhacc.h instruction (packed multiply high accumulate halfword).
# Performs two 16-bit signed multiplies and accumulates high 32-bit results.
# rd[31:0] = rd[31:0] + (sext(rs1[15:0]) * sext(rs2[15:0])) >> 16
# rd[63:32] = rd[63:32] + (sext(rs1[31:16]) * sext(rs2[31:16])) >> 16
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + (3 * 7) >> 16 = 0 (lower), 0 + (5 * 11) >> 16 = 0 (upper)
  TEST_CASE( 2, x3, 0x00000000, \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pmhacc.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) >> 16 = 100 (lower), 200 + (7 * 14) >> 16 = 200 (upper)
  TEST_CASE( 3, x3, 0x000000c8, \
    li  x3, 0x000000c8; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pmhacc.h x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x1000 * 0x1000) >> 16 = 0x100 (lower)
  TEST_CASE( 4, x3, 0x00000100, \
    li  x3, 0x00000000; \
    li  x1, 0x10001000; \
    li  x2, 0x10001000; \
    pmhacc.h x3, x1, x2; \
  )

  # Negative multiply: 0 + ((-10) * 20) >> 16 = 0xffffffff (lower)
  TEST_CASE( 5, x3, 0xffffffff, \
    li  x3, 0x00000000; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pmhacc.h x3, x1, x2; \
  )

  # Both negative: 0 + ((-100) * (-100)) >> 16 = 0x271 (lower)
  TEST_CASE( 6, x3, 0x00000271, \
    li  x3, 0x00000000; \
    li  x1, 0xff9cff9c; \
    li  x2, 0xff9cff9c; \
    pmhacc.h x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) >> 16 = 500 (lower)
  TEST_CASE( 7, x3, 0x000001f4, \
    li  x3, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pmhacc.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

