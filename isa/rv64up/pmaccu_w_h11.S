# See LICENSE for license details.

#*****************************************************************************
# pmaccu_w_h11.S
#-----------------------------------------------------------------------------
#
# Test pmaccu.w.h11 instruction (packed multiply-accumulate unsigned word top-top).
# Performs 32-bit unsigned multiply on upper halfwords and accumulates result.
# rd = rd + (zext(rs1[31:16]) * zext(rs2[31:16]))
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + (3 * 7) = 21
  TEST_CASE( 2, x3, 0x0000000000000015, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000030000; \
    li  x2, 0x0000000000070000; \
    pmaccu.w.h11 x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000050000; \
    li  x2, 0x000000000000a000; \
    pmaccu.w.h11 x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x1000 * 0x1000) = 0x1000000
  TEST_CASE( 4, x3, 0x0000000001000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000010000000; \
    li  x2, 0x0000000010000000; \
    pmaccu.w.h11 x3, x1, x2; \
  )

  # Large unsigned multiply: 0 + (0xffff * 0xffff) = 0xfffe0001
  TEST_CASE( 5, x3, 0x00000000fffe0001, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x00000000ffff0000; \
    li  x2, 0x00000000ffff0000; \
    pmaccu.w.h11 x3, x1, x2; \
  )

  # Large unsigned with accumulation: 100 + (0xffff * 0xffff) = 0xfffe0065
  TEST_CASE( 6, x3, 0x00000000fffe0065, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x00000000ffff0000; \
    li  x2, 0x00000000ffff0000; \
    pmaccu.w.h11 x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) = 500
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000640000; \
    pmaccu.w.h11 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

