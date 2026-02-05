# See LICENSE for license details.

#*****************************************************************************
# pmhaccu_w.S
#-----------------------------------------------------------------------------
#
# Test pmhaccu.w instruction (packed multiply high accumulate unsigned word).
# Performs two 32-bit unsigned multiplies and accumulates high 64-bit results.
# rd[63:32] = rd[63:32] + (zext(rs1[31:0]) * zext(rs2[31:0])) >> 32
# rd[31:0] = rd[31:0] + (zext(rs1[63:32]) * zext(rs2[63:32])) >> 32
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
    pmhaccu.w x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100 (lower)
  TEST_CASE( 3, x3, 0x0000006400000064, \
    li  x3, 0x0000006400000064; \
    li  x1, 0x000b0005; \
    li  x2, 0x000e000a; \
    pmhaccu.w x3, x1, x2; \
  )

  # Larger multiply: 0 + (0x100000 * 0x100000) >> 32 = 0x10000 (lower)
  TEST_CASE( 4, x3, 0x0000000000010000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x00100000; \
    li  x2, 0x00100000; \
    pmhaccu.w x3, x1, x2; \
  )

  # Large unsigned multiply: 0 + (0xffffffff * 0xffffffff) >> 32 = 0xfffffffe (lower)
  TEST_CASE( 5, x3, 0x00000000fffffffe, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pmhaccu.w x3, x1, x2; \
  )

  # Large unsigned with accumulation: 100 + (0xffffffff * 0xffffffff) >> 32 = 0xfffffffe + 100
  TEST_CASE( 6, x3, 0x0000000100000064, \
    li  x3, 0x0000000100000064; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pmhaccu.w x3, x1, x2; \
  )

  # Zero multiply: 500 + (0 * 100) >> 32 = 500 (lower)
  TEST_CASE( 7, x3, 0x00000000000001f4, \
    li  x3, 0x00000000000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pmhaccu.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

