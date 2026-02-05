# See LICENSE for license details.

#*****************************************************************************
# pmhraccu_h.S
#-----------------------------------------------------------------------------
#
# Test pmhraccu.h instruction (packed multiply high with rounding accumulate unsigned).
# Performs two 16-bit unsigned multiplies with rounding and accumulates high 32-bit results.
# rd[31:0] = rd[31:0] + round((zext(rs1[15:0]) * zext(rs2[15:0])) >> 15)
# rd[63:32] = rd[63:32] + round((zext(rs1[31:16]) * zext(rs2[31:16])) >> 15)
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
    pmhraccu.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + round((5 * 10) >> 15) = 100 (lower)
  TEST_CASE( 3, x3, 0x00000064, \
    li  x3, 0x00000064; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pmhraccu.h x3, x1, x2; \
  )

  # Larger multiply with rounding: 0 + round((0x1000 * 0x1000) >> 15) = 0 + 0x200 = 0x200 (lower)
  TEST_CASE( 4, x3, 0x00000200, \
    li  x3, 0x00000000; \
    li  x1, 0x10001000; \
    li  x2, 0x10001000; \
    pmhraccu.h x3, x1, x2; \
  )

  # Large unsigned values: 0 + round((0xffff * 0xffff) >> 15) = 0 + 0x1fffd = 0x1fffd (lower)
  TEST_CASE( 5, x3, 0x0001fffd, \
    li  x3, 0x00000000; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pmhraccu.h x3, x1, x2; \
  )

  # Mixed values: 0 + round((0x8000 * 0x8000) >> 15) = 0 + 0x8000 = 0x8000 (lower)
  TEST_CASE( 6, x3, 0x00008000, \
    li  x3, 0x00000000; \
    li  x1, 0x80008000; \
    li  x2, 0x80008000; \
    pmhraccu.h x3, x1, x2; \
  )

  # Zero multiply: 500 + round((0 * 100) >> 15) = 500 (lower)
  TEST_CASE( 7, x3, 0x000001f4, \
    li  x3, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pmhraccu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

