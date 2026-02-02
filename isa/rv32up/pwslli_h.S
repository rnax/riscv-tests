# See LICENSE for license details.

#*****************************************************************************
# pwslli_h.S
#-----------------------------------------------------------------------------
#
# Test pwslli.h instruction (packed widening shift left logical immediate halfword).
# Shifts 16-bit values left by immediate and produces 32-bit results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0005 << 0 = 0x00000005
  TEST_CASE( 2, x3, 0x00000005, \
    li  x1, 0x00050000; \
    pwslli.h x3, x1, 0; \
  )

  # Shift by 1: 0x0005 << 1 = 0x0000000a
  TEST_CASE( 3, x3, 0x0000000a, \
    li  x1, 0x00050000; \
    pwslli.h x3, x1, 1; \
  )

  # Shift by 8: 0x00ff << 8 = 0x0000ff00
  TEST_CASE( 4, x3, 0x0000ff00, \
    li  x1, 0x00ff0000; \
    pwslli.h x3, x1, 8; \
  )

  # Shift by 15: 0x0001 << 15 = 0x00008000
  TEST_CASE( 5, x3, 0x00008000, \
    li  x1, 0x00010000; \
    pwslli.h x3, x1, 15; \
  )

  # Shift max: 0xffff << 0 = 0x0000ffff
  TEST_CASE( 6, x3, 0x0000ffff, \
    li  x1, 0xffff0000; \
    pwslli.h x3, x1, 0; \
  )

  # Shift by 4: 0x0100 << 4 = 0x00001000
  TEST_CASE( 7, x3, 0x00001000, \
    li  x1, 0x01000000; \
    pwslli.h x3, x1, 4; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

