# See LICENSE for license details.

#*****************************************************************************
# pwsub_h.S
#-----------------------------------------------------------------------------
#
# Test pwsub.h instruction (packed widening signed subtract halfword).
# Subtracts two 16-bit signed values and produces 32-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening subtract: 0x000a - 0x0004 = 0x00000006
  TEST_CASE( 2, x3, 0x00000006, \
    li  x1, 0x000a0000; \
    li  x2, 0x00040000; \
    pwsub.h x3, x1, x2; \
  )

  # Widening subtract with negative result: 0x0004 - 0x000a = -6 (0xfffffffa)
  TEST_CASE( 3, x3, 0xfffffffa, \
    li  x1, 0x00040000; \
    li  x2, 0x000a0000; \
    pwsub.h x3, x1, x2; \
  )

  # Negative subtract: -4 - (-6) = 2
  TEST_CASE( 4, x3, 0x00000002, \
    li  x1, 0xfffc0000; \
    li  x2, 0xfffa0000; \
    pwsub.h x3, x1, x2; \
  )

  # Subtract from zero: 0 - 5 = -5 (0xfffffffb)
  TEST_CASE( 5, x3, 0xfffffffb, \
    li  x1, 0x00000000; \
    li  x2, 0x00050000; \
    pwsub.h x3, x1, x2; \
  )

  # Zero subtract: 5 - 0 = 5
  TEST_CASE( 6, x3, 0x00000005, \
    li  x1, 0x00050000; \
    li  x2, 0x00000000; \
    pwsub.h x3, x1, x2; \
  )

  # Different operands: 0x0014 - 0x000a = 0x0000000a
  TEST_CASE( 7, x3, 0x0000000a, \
    li  x1, 0x00140000; \
    li  x2, 0x000a0000; \
    pwsub.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

