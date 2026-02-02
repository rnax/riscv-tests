# See LICENSE for license details.

#*****************************************************************************
# pwadd_b.S
#-----------------------------------------------------------------------------
#
# Test pwadd.b instruction (packed widening signed add byte).
# Adds two 8-bit signed values and produces 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening add: 4 + 6 = 10 (in both bytes)
  TEST_CASE( 2, x3, 0x000a000a, \
    li  x1, 0x04060406; \
    pwadd.b x3, x1, x1; \
  )

  # Widening add with larger values: 0x7f + 0x7f = 0x00fe (in both bytes)
  TEST_CASE( 3, x3, 0x00fe00fe, \
    li  x1, 0x7f7f7f7f; \
    pwadd.b x3, x1, x1; \
  )

  # Negative widening add: -4 + -6 = -10 (0xfff6 in both bytes)
  TEST_CASE( 4, x3, 0xfff6fff6, \
    li  x1, 0xfcfafcfa; \
    pwadd.b x3, x1, x1; \
  )

  # Mixed sign: -1 + 1 = 0 (in both bytes)
  TEST_CASE( 5, x3, 0x00000000, \
    li  x1, 0xffff0101; \
    pwadd.b x3, x1, x1; \
  )

  # Zero cases
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    pwadd.b x3, x1, x1; \
  )

  # Different operands: 10 + 20 = 30, 5 + 15 = 20
  TEST_CASE( 7, x3, 0x001e0014, \
    li  x1, 0x0a050000; \
    li  x2, 0x140f0000; \
    pwadd.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

