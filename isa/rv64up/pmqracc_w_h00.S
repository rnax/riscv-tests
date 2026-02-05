# See LICENSE for license details.

#*****************************************************************************
# pmqracc_w_h00.S
#-----------------------------------------------------------------------------
#
# Test pmqracc.w.h00 instruction (packed Q-format multiply-accumulate with rounding word bottom-bottom).
# Performs 32-bit signed Q-format multiply on lower words with rounding and accumulates result.
# rd = rd + ((sext(rs1[31:0]) * sext(rs2[31:0])) >> 31 + rounding)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply with rounding: 0 + (0.5 * 0.5) = 0.25
  # 0 + (0x40000000 * 0x40000000 >> 31 + rounding) = 0x20000000
  TEST_CASE( 2, x3, 0x0000000020000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqracc.w.h00 x3, x1, x2; \
  )

  # Accumulate to existing value: 0x10000000 + (0.5 * 0.5) = 0x30000000
  TEST_CASE( 3, x3, 0x0000000030000000, \
    li  x3, 0x0000000010000000; \
    li  x1, 0x4000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqracc.w.h00 x3, x1, x2; \
  )

  # Negative Q-format: 0 + (-0.5 * 0.5) = -0.25
  # 0 + (0xC0000000 * 0x40000000 >> 31 + rounding) = 0xFFFFFFFFE0000000
  TEST_CASE( 4, x3, 0xffffffffe0000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000040000000; \
    li  x2, 0x4000000040000000; \
    pmqracc.w.h00 x3, x1, x2; \
  )

  # Both negative: 0 + (-0.5 * -0.5) = 0.25
  # 0 + (0xC0000000 * 0xC0000000 >> 31 + rounding) = 0x20000000
  TEST_CASE( 5, x3, 0x0000000020000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0xc000000040000000; \
    li  x2, 0xc000000040000000; \
    pmqracc.w.h00 x3, x1, x2; \
  )

  # One (Q31: 0x7FFFFFFF) * 0.5 = 0.5
  # 0 + (0x7FFFFFFF * 0x40000000 >> 31 + rounding) = 0x40000000
  TEST_CASE( 6, x3, 0x0000000040000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x7fffffff7fffffff; \
    li  x2, 0x4000000040000000; \
    pmqracc.w.h00 x3, x1, x2; \
  )

  # Zero multiply: 0x100 + (0 * 0.5) = 0x100
  TEST_CASE( 7, x3, 0x0000000000000100, \
    li  x3, 0x0000000000000100; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x4000000040000000; \
    pmqracc.w.h00 x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

