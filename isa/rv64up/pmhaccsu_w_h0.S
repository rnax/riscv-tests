# See LICENSE for license details.

#*****************************************************************************
# pmhaccsu_w_h0.S
#-----------------------------------------------------------------------------
#
# Test pmhaccsu.w.h0 instruction (packed multiply high accumulate signed*unsigned word bottom).
# Performs 32-bit signed*unsigned multiply on lower words and accumulates high 32-bit result.
# rd[31:0] = rd[31:0] + (sext(rs1[31:0]) * zext(rs2[31:0])) >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + (3 * 7) >> 32 = 0
  TEST_CASE( 2, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000000003; \
    li  x2, 0x0000000000000007; \
    pmhaccsu.w.h0 x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100
  TEST_CASE( 3, x3, 0x0000000000000064, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000000000000000a; \
    pmhaccsu.w.h0 x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x100000 * 0x100000) >> 32 = 0x10000
  TEST_CASE( 4, x3, 0x0000000000010000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000100000; \
    li  x2, 0x0000000000100000; \
    pmhaccsu.w.h0 x3, x1, x2; \
  )

  # Negative signed with unsigned: 0 + ((-10) * 20) >> 32 = 0xffffffff
  TEST_CASE( 5, x3, 0xffffffffffffffff, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xfffffffffffffff6; \
    li  x2, 0x0000000000000014; \
    pmhaccsu.w.h0 x3, x1, x2; \
  )

  # Negative signed with large unsigned: 0 + ((-100) * 0xffffffff) >> 32 = 0xffffff9c
  TEST_CASE( 6, x3, 0xffffff9c00000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xffffffffffffff9c; \
    li  x2, 0xffffffffffffffff; \
    pmhaccsu.w.h0 x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) >> 32 = 500
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000000064; \
    pmhaccsu.w.h0 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

