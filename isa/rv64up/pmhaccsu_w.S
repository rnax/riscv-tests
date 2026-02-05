# See LICENSE for license details.

#*****************************************************************************
# pmhaccsu_w.S
#-----------------------------------------------------------------------------
#
# Test pmhaccsu.w instruction (packed multiply high accumulate signed*unsigned word).
# Performs two 32-bit signed*unsigned multiplies and accumulates high 64-bit results.
# rd[63:32] = rd[63:32] + (sext(rs1[31:0]) * zext(rs2[31:0])) >> 32
# rd[31:0] = rd[31:0] + (sext(rs1[63:32]) * zext(rs2[63:32])) >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + (3 * 7) >> 32 = 0 (lower), 0 + (5 * 11) >> 32 = 0 (upper)
  TEST_CASE( 2, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pmhaccsu.w x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100 (lower)
  TEST_CASE( 3, x3, 0x0000006400000064, \
    li  x3, 0x0000006400000064; \
    li  x1, 0x000b0005; \
    li  x2, 0x000e000a; \
    pmhaccsu.w x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x100000 * 0x100000) >> 32 = 0x10000 (lower)
  TEST_CASE( 4, x3, 0x0000000000010000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x00100000; \
    li  x2, 0x00100000; \
    pmhaccsu.w x3, x1, x2; \
  )

  # Negative signed with unsigned: 0 + ((-10) * 20) >> 32 = 0xffffffff (lower)
  TEST_CASE( 5, x3, 0xffffffffffffffff, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xfffffff6; \
    li  x2, 0x00000014; \
    pmhaccsu.w x3, x1, x2; \
  )

  # Negative signed with large unsigned: 0 + ((-100) * 0xffffffff) >> 32 = 0xffffff9c
  TEST_CASE( 6, x3, 0xffffff9c00000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xffffff9c; \
    li  x2, 0xffffffff; \
    pmhaccsu.w x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) >> 32 = 500 (lower)
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pmhaccsu.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

