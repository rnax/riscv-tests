# See LICENSE for license details.

#*****************************************************************************
# pwsll_bs.S
#-----------------------------------------------------------------------------
#
# Test pwsll.b instruction (packed widening shift left logical byte).
# Shifts 8-bit values left and produces 16-bit results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic shift: 0x05 << 0 = 0x0005 (in both bytes)
  TEST_CASE( 2, x3, 0x00050005, \
    li  x1, 0x05060506; \
    li  x2, 0x00000000; \
    pwsll.b x3, x1, x2; \
  )

  # Shift by 1: 0x05 << 1 = 0x000a (in both bytes)
  TEST_CASE( 3, x3, 0x000a000a, \
    li  x1, 0x05060506; \
    li  x2, 0x00000001; \
    pwsll.b x3, x1, x2; \
  )

  # Shift by 4: 0x0f << 4 = 0x00f0 (in both bytes)
  TEST_CASE( 4, x3, 0x00f000f0, \
    li  x1, 0x0f0f0f0f; \
    li  x2, 0x00000004; \
    pwsll.b x3, x1, x2; \
  )

  # Shift by 7: 0x01 << 7 = 0x0080 (in both bytes)
  TEST_CASE( 5, x3, 0x00800080, \
    li  x1, 0x01020102; \
    li  x2, 0x00000007; \
    pwsll.b x3, x1, x2; \
  )

  # Shift max: 0xff << 0 = 0x00ff (in both bytes)
  TEST_CASE( 6, x3, 0x00ff00ff, \
    li  x1, 0xffffffff; \
    li  x2, 0x00000000; \
    pwsll.b x3, x1, x2; \
  )

  # Different operands: 0x03 << 2 = 0x000c, 0x07 << 3 = 0x0038
  TEST_CASE( 7, x3, 0x0038000c, \
    li  x1, 0x03070000; \
    li  x2, 0x00000002; \
    pwsll.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

