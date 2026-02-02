# See LICENSE for license details.

#*****************************************************************************
# pmqrwacc.S
#-----------------------------------------------------------------------------
#
# Test pmqrwacc instruction (packed Q-format widening multiply-accumulate with rounding).
# Performs Q-format fixed-point multiply with rounding and accumulation.
# rd = rd + (((rs1 * rs2) + 0x4000) >> 15)
# Q15 fixed-point multiply with rounding and accumulation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply with rounding: 0.5 * 0.5 = 0.25
  # (0x4000 * 0x4000 + 0x4000) >> 15 = 0x2000
  TEST_CASE( 2, x3, 0x00002000, \
    li  x3, 0x00000000; \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqrwacc x3, x1, x2; \
  )

  # Accumulate to existing value with rounding: 0x1000 + ((0x4000 * 0x4000 + 0x4000) >> 15) = 0x3000
  TEST_CASE( 3, x3, 0x00003000, \
    li  x3, 0x00001000; \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqrwacc x3, x1, x2; \
  )

  # Negative Q-format with rounding: -0.5 * 0.5 = -0.25
  # (0xC000 * 0x4000 + 0x4000) >> 15 = 0xE000
  TEST_CASE( 4, x3, 0xffffe000, \
    li  x3, 0x00000000; \
    li  x1, 0xC000C000; \
    li  x2, 0x40004000; \
    pmqrwacc x3, x1, x2; \
  )

  # Both negative with rounding: -0.5 * -0.5 = 0.25
  # (0xC000 * 0xC000 + 0x4000) >> 15 = 0x2000
  TEST_CASE( 5, x3, 0x00002000, \
    li  x3, 0x00000000; \
    li  x1, 0xC000C000; \
    li  x2, 0xC000C000; \
    pmqrwacc x3, x1, x2; \
  )

  # Small values with rounding: 0.1 * 0.1 ≈ 0.01
  # (0x0CCD * 0x0CCD + 0x4000) >> 15 ≈ 0x0106
  TEST_CASE( 6, x3, 0x00000106, \
    li  x3, 0x00000000; \
    li  x1, 0x0CCD0CCD; \
    li  x2, 0x0CCD0CCD; \
    pmqrwacc x3, x1, x2; \
  )

  # Zero multiply with rounding: 0 * 0.5 = 0
  TEST_CASE( 7, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x40004000; \
    pmqrwacc x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

