# See LICENSE for license details.

#*****************************************************************************
# maccu_w00.S
#-----------------------------------------------------------------------------
#
# Test maccu.w00 instruction (multiply-accumulate unsigned word bottom-bottom).
# Performs 32-bit unsigned multiply on lower words and accumulates result.
# rd = rd + (zext(rs1[31:0]) * zext(rs2[31:0]))
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
    maccu.w00 x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000000000000000a; \
    maccu.w00 x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x1000 * 0x1000) = 0x1000000
  TEST_CASE( 4, x3, 0x0000000001000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000001000; \
    li  x2, 0x0000000000001000; \
    maccu.w00 x3, x1, x2; \
  )

  # Large unsigned multiply: 0 + (0xffffffff * 0xffffffff) = 0xfffffffe00000001
  TEST_CASE( 5, x3, 0xfffffffe00000001, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xffffffffffffffff; \
    li  x2, 0xffffffffffffffff; \
    maccu.w00 x3, x1, x2; \
  )

  # Medium unsigned multiply: 0 + (0x10000 * 0x10000) = 0x100000000
  TEST_CASE( 6, x3, 0x0000000100000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000010000; \
    li  x2, 0x0000000000010000; \
    maccu.w00 x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) = 500
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000000064; \
    maccu.w00 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

