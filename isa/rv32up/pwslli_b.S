# See LICENSE for license details.

#*****************************************************************************
# pwslli_b.S
#-----------------------------------------------------------------------------
#
# Test pwslli.b instruction (packed widening shift left logical immediate byte).
# Shifts 8-bit values left by immediate and produces 16-bit results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x05 << 0 = 0x0005 (in both bytes)
  TEST_CASE( 2, x3, 0x00050005, \
    li  x1, 0x05060506; \
    pwslli.b x3, x1, 0; \
  )

  # Shift by 1: 0x05 << 1 = 0x000a (in both bytes)
  TEST_CASE( 3, x3, 0x000a000a, \
    li  x1, 0x05060506; \
    pwslli.b x3, x1, 1; \
  )

  # Shift by 4: 0x0f << 4 = 0x00f0 (in both bytes)
  TEST_CASE( 4, x3, 0x00f000f0, \
    li  x1, 0x0f0f0f0f; \
    pwslli.b x3, x1, 4; \
  )

  # Shift by 7: 0x01 << 7 = 0x0080 (in both bytes)
  TEST_CASE( 5, x3, 0x00800080, \
    li  x1, 0x01020102; \
    pwslli.b x3, x1, 7; \
  )

  # Shift max: 0xff << 0 = 0x00ff (in both bytes)
  TEST_CASE( 6, x3, 0x00ff00ff, \
    li  x1, 0xffffffff; \
    pwslli.b x3, x1, 0; \
  )

  # Shift by 3: 0x10 << 3 = 0x0080 (in both bytes)
  TEST_CASE( 7, x3, 0x00800080, \
    li  x1, 0x10101010; \
    pwslli.b x3, x1, 3; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

