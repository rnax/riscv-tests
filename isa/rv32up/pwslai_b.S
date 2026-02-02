# See LICENSE for license details.

#*****************************************************************************
# pwslai_b.S
#-----------------------------------------------------------------------------
#
# Test pwslai.b instruction (packed widening shift left arithmetic immediate byte).
# Shifts 8-bit signed values left by immediate and produces 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive shift by 0: 0x05 << 0 = 0x0005 (in both bytes)
  TEST_CASE( 2, x3, 0x00050005, \
    li  x1, 0x05060506; \
    pwslai.b x3, x1, 0; \
  )

  # Positive shift by 1: 0x05 << 1 = 0x000a (in both bytes)
  TEST_CASE( 3, x3, 0x000a000a, \
    li  x1, 0x05060506; \
    pwslai.b x3, x1, 1; \
  )

  # Negative shift by 1: -0x05 << 1 = -0x000a (0xfff6 in both bytes)
  TEST_CASE( 4, x3, 0xfff6fff6, \
    li  x1, 0xfbfafbfa; \
    pwslai.b x3, x1, 1; \
  )

  # Negative shift by 4: -0x01 << 4 = -0x0010 (0xfff0 in both bytes)
  TEST_CASE( 5, x3, 0xfff0fff0, \
    li  x1, 0xfffffeff; \
    pwslai.b x3, x1, 4; \
  )

  # Max positive: 0x7f << 0 = 0x007f (in both bytes)
  TEST_CASE( 6, x3, 0x007f007f, \
    li  x1, 0x7f7f7f7f; \
    pwslai.b x3, x1, 0; \
  )

  # Shift by 3: 0x10 << 3 = 0x0080 (in both bytes)
  TEST_CASE( 7, x3, 0x00800080, \
    li  x1, 0x10101010; \
    pwslai.b x3, x1, 3; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

