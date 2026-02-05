# See LICENSE for license details.

#*****************************************************************************
# maccsu_w00.S
#-----------------------------------------------------------------------------
#
# Test maccsu.w00 instruction (multiply-accumulate signed*unsigned word bottom-bottom).
# Performs 32-bit signed*unsigned multiply on lower words and accumulates result.
# rd = rd + (sext(rs1[31:0]) * zext(rs2[31:0]))
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
    li  x1, 0x0000000000000003; \
    li  x2, 0x0000000000000007; \
    maccsu.w00 x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000000000000000a; \
    maccsu.w00 x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x1000 * 0x1000) = 0x1000000
  TEST_CASE( 4, x3, 0x0000000001000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000001000; \
    li  x2, 0x0000000000001000; \
    maccsu.w00 x3, x1, x2; \
  )

  # Negative signed with unsigned: 0 + ((-10) * 20) = -200
  TEST_CASE( 5, x3, 0xffffffffffffff38, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xfffffffffffffff6; \
    li  x2, 0x0000000000000014; \
    maccsu.w00 x3, x1, x2; \
  )

  # Negative signed with large unsigned: 0 + ((-100) * 0xffffffff) = 0x63c00064
  TEST_CASE( 6, x3, 0x0000000063c00064, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xffffffffffffff9c; \
    li  x2, 0xffffffffffffffff; \
    maccsu.w00 x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) = 500
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000000064; \
    maccsu.w00 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

