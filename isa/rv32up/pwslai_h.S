# See LICENSE for license details.

#*****************************************************************************
# pwslai_h.S
#-----------------------------------------------------------------------------
#
# Test pwslai.h instruction (packed widening shift left arithmetic immediate halfword).
# Shifts 16-bit signed values left by immediate and produces 32-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive shift by 0: 0x0005 << 0 = 0x00000005
  TEST_CASE( 2, x3, 0x00000005, \
    li  x1, 0x00050000; \
    pwslai.h x3, x1, 0; \
  )

  # Positive shift by 1: 0x0005 << 1 = 0x0000000a
  TEST_CASE( 3, x3, 0x0000000a, \
    li  x1, 0x00050000; \
    pwslai.h x3, x1, 1; \
  )

  # Negative shift by 1: -0x0005 << 1 = -0x000a (0xfffffff6)
  TEST_CASE( 4, x3, 0xfffffff6, \
    li  x1, 0xfffb0000; \
    pwslai.h x3, x1, 1; \
  )

  # Negative shift by 8: -0x0001 << 8 = -0x0100 (0xfffffeff)
  TEST_CASE( 5, x3, 0xfffffeff, \
    li  x1, 0xffff0000; \
    pwslai.h x3, x1, 8; \
  )

  # Max positive: 0x7fff << 0 = 0x00007fff
  TEST_CASE( 6, x3, 0x00007fff, \
    li  x1, 0x7fff0000; \
    pwslai.h x3, x1, 0; \
  )

  # Shift by 4: 0x0100 << 4 = 0x00001000
  TEST_CASE( 7, x3, 0x00001000, \
    li  x1, 0x01000000; \
    pwslai.h x3, x1, 4; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

