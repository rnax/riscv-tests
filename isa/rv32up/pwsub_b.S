# See LICENSE for license details.

#*****************************************************************************
# pwsub_b.S
#-----------------------------------------------------------------------------
#
# Test pwsub.b instruction (packed widening signed subtract byte).
# Subtracts two 8-bit signed values and produces 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening subtract: 10 - 4 = 6 (in both bytes)
  TEST_CASE( 2, x3, 0x00060006, \
    li  x1, 0x0a0a0a0a; \
    li  x2, 0x04040404; \
    pwsub.b x3, x1, x2; \
  )

  # Widening subtract with negative result: 4 - 10 = -6 (0xfffa in both bytes)
  TEST_CASE( 3, x3, 0xfffffffa, \
    li  x1, 0x04040404; \
    li  x2, 0x0a0a0a0a; \
    pwsub.b x3, x1, x2; \
  )

  # Negative subtract: -4 - (-6) = 2 (in both bytes)
  TEST_CASE( 4, x3, 0x00020002, \
    li  x1, 0xfcfcfcfc; \
    li  x2, 0xfafafafa; \
    pwsub.b x3, x1, x2; \
  )

  # Subtract from zero: 0 - 5 = -5 (0xfffb in both bytes)
  TEST_CASE( 5, x3, 0xfffffffb, \
    li  x1, 0x00000000; \
    li  x2, 0x05050505; \
    pwsub.b x3, x1, x2; \
  )

  # Zero subtract: 5 - 0 = 5 (in both bytes)
  TEST_CASE( 6, x3, 0x00050005, \
    li  x1, 0x05050505; \
    li  x2, 0x00000000; \
    pwsub.b x3, x1, x2; \
  )

  # Different operands: 20 - 10 = 10, 15 - 5 = 10
  TEST_CASE( 7, x3, 0x000a000a, \
    li  x1, 0x140f0000; \
    li  x2, 0x0a050000; \
    pwsub.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

