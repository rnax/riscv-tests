# See LICENSE for license details.

#*****************************************************************************
# pwaddu_b.S
#-----------------------------------------------------------------------------
#
# Test pwaddu.b instruction (packed widening unsigned add byte).
# Adds two 8-bit unsigned values and produces 16-bit unsigned results.
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
    pwaddu.b x3, x1, x1; \
  )

  # Widening add with larger values: 0xff + 0xff = 0x01fe (in both bytes)
  TEST_CASE( 3, x3, 0x01fe01fe, \
    li  x1, 0xffffffff; \
    pwaddu.b x3, x1, x1; \
  )

  # Widening add: 0x80 + 0x80 = 0x0100 (in both bytes)
  TEST_CASE( 4, x3, 0x01000100, \
    li  x1, 0x80808080; \
    pwaddu.b x3, x1, x1; \
  )

  # Mixed values: 0x00 + 0xff = 0x00ff (in both bytes)
  TEST_CASE( 5, x3, 0x00ff00ff, \
    li  x1, 0x00ff00ff; \
    pwaddu.b x3, x1, x1; \
  )

  # Zero cases
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    pwaddu.b x3, x1, x1; \
  )

  # Different operands: 10 + 20 = 30, 5 + 15 = 20
  TEST_CASE( 7, x3, 0x001e0014, \
    li  x1, 0x0a050000; \
    li  x2, 0x140f0000; \
    pwaddu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

