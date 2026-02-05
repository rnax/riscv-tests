# See LICENSE for license details.

#*****************************************************************************
# pmq2adda_w.S
#-----------------------------------------------------------------------------
#
# Test pmq2adda.w instruction (packed Q-format 2-way multiply-add accumulate word).
# Performs two 32-bit Q-format multiplies and accumulates results to 64-bit accumulators.
# rd[31:0] = rd[31:0] + (sext(rs1[31:0]) * sext(rs2[31:0])) >> 31
# rd[63:32] = rd[63:32] + (sext(rs1[63:32]) * sext(rs2[63:32])) >> 31
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply-accumulate: 0 + (0.5 * 0.5) = 0.25
  # 0 + (0x40000000 * 0x40000000 >> 31) = 0x20000000
  TEST_CASE( 2, x3, 0x0000000020000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmq2adda.w x3, x1, x2; \
  )

  # Accumulate to existing value: 0x10000000 + (0.5 * 0.5) = 0x30000000
  TEST_CASE( 3, x3, 0x0000000030000000, \
    li  x3, 0x0000000010000000; \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmq2adda.w x3, x1, x2; \
  )

  # Negative Q-format: 0 + (-0.5 * 0.5) = -0.25
  # 0 + (0xC0000000 * 0x40000000 >> 31) = 0xFFFFFFFFE0000000
  TEST_CASE( 4, x3, 0xffffffffe0000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000040000000; \
    li  x2, 0x4000000040000000; \
    pmq2adda.w x3, x1, x2; \
  )

  # Both negative: 0 + (-0.5 * -0.5) = 0.25
  # 0 + (0xC0000000 * 0xC0000000 >> 31) = 0x20000000
  TEST_CASE( 5, x3, 0x0000000020000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000040000000; \
    li  x2, 0xc000000040000000; \
    pmq2adda.w x3, x1, x2; \
  )

  # Zero multiply: 0x100 + (0 * 0.5) = 0x100
  TEST_CASE( 6, x3, 0x0000000000000100, \
    li  x3, 0x0000000000000100; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x4000000040000000; \
    pmq2adda.w x3, x1, x2; \
  )

  # One (Q31: 0x7FFFFFFF) * 0.5 = 0.5
  # 0x100 + (0x7FFFFFFF * 0x40000000 >> 31) = 0x100 + 0x3FFFFFFF = 0x400000FF
  TEST_CASE( 7, x3, 0x00000000400000ff, \
    li  x3, 0x0000000000000100; \
    li  x1, 0x7fffffff7fffffff; \
    li  x2, 0x4000000040000000; \
    pmq2adda.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

