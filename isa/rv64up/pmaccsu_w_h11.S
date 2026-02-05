# See LICENSE for license details.

#*****************************************************************************
# pmaccsu_w_h11.S
#-----------------------------------------------------------------------------
#
# Test pmaccsu.w.h11 instruction (packed multiply-accumulate signed*unsigned word top-top).
# Performs 32-bit signed*unsigned multiply on upper halfwords and accumulates result.
# rd = rd + (sext(rs1[31:16]) * zext(rs2[31:16]))
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
    pmaccsu.w.h11 x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000050000; \
    li  x2, 0x000000000000a000; \
    pmaccsu.w.h11 x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x1000 * 0x1000) = 0x1000000
  TEST_CASE( 4, x3, 0x0000000001000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000010000000; \
    li  x2, 0x0000000010000000; \
    pmaccsu.w.h11 x3, x1, x2; \
  )

  # Negative signed with unsigned: 0 + ((-10) * 20) = -200
  TEST_CASE( 5, x3, 0xffffffffffffff38, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xfffffffffffffff6; \
    li  x2, 0x0000000000140000; \
    pmaccsu.w.h11 x3, x1, x2; \
  )

  # Negative signed with large unsigned: 0 + ((-100) * 0xffff) = -6553500
  TEST_CASE( 6, x3, 0xffffffffff9c0064, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xffffffffffffff9c; \
    li  x2, 0xffff000000000000; \
    pmaccsu.w.h11 x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) = 500
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000640000; \
    pmaccsu.w.h11 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

