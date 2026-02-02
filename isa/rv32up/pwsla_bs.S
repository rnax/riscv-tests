# See LICENSE for license details.

#*****************************************************************************
# pwsla_bs.S
#-----------------------------------------------------------------------------
#
# Test pwsla.b instruction (packed widening shift left arithmetic byte).
# Shifts 8-bit signed values left and produces 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive shift: 0x05 << 0 = 0x0005 (in both bytes)
  TEST_CASE( 2, x3, 0x00050005, \
    li  x1, 0x05060506; \
    li  x2, 0x00000000; \
    pwsla.b x3, x1, x2; \
  )

  # Positive shift by 1: 0x05 << 1 = 0x000a (in both bytes)
  TEST_CASE( 3, x3, 0x000a000a, \
    li  x1, 0x05060506; \
    li  x2, 0x00000001; \
    pwsla.b x3, x1, x2; \
  )

  # Negative shift: -0x05 << 1 = -0x000a (0xfff6 in both bytes)
  TEST_CASE( 4, x3, 0xfff6fff6, \
    li  x1, 0xfbfafbfa; \
    li  x2, 0x00000001; \
    pwsla.b x3, x1, x2; \
  )

  # Negative shift by 4: -0x01 << 4 = -0x0010 (0xfff0 in both bytes)
  TEST_CASE( 5, x3, 0xfff0fff0, \
    li  x1, 0xfffffeff; \
    li  x2, 0x00000004; \
    pwsla.b x3, x1, x2; \
  )

  # Max positive: 0x7f << 0 = 0x007f (in both bytes)
  TEST_CASE( 6, x3, 0x007f007f, \
    li  x1, 0x7f7f7f7f; \
    li  x2, 0x00000000; \
    pwsla.b x3, x1, x2; \
  )

  # Different operands: 0x03 << 2 = 0x000c, -0x02 << 3 = -0x0010
  TEST_CASE( 7, x3, 0xfff0000c, \
    li  x1, 0x03fe0000; \
    li  x2, 0x00000002; \
    pwsla.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

