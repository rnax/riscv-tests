# See LICENSE for license details.

#*****************************************************************************
# pwsubu_b.S
#-----------------------------------------------------------------------------
#
# Test pwsubu.b instruction (packed widening unsigned subtract byte).
# Subtracts two 8-bit unsigned values and produces 16-bit unsigned results.
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
    pwsubu.b x3, x1, x2; \
  )

  # Widening subtract with borrow: 4 - 10 = -6 (0xfffa in both bytes, unsigned wraps)
  TEST_CASE( 3, x3, 0xfffffffa, \
    li  x1, 0x04040404; \
    li  x2, 0x0a0a0a0a; \
    pwsubu.b x3, x1, x2; \
  )

  # Unsigned subtract: 0x80 - 0x80 = 0 (in both bytes)
  TEST_CASE( 4, x3, 0x00000000, \
    li  x1, 0x80808080; \
    li  x2, 0x80808080; \
    pwsubu.b x3, x1, x2; \
  )

  # Unsigned subtract: 0xff - 0x00 = 0x00ff (in both bytes)
  TEST_CASE( 5, x3, 0x00ff00ff, \
    li  x1, 0xffffffff; \
    li  x2, 0x00000000; \
    pwsubu.b x3, x1, x2; \
  )

  # Zero subtract: 0 - 0 = 0 (in both bytes)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x00000000; \
    pwsubu.b x3, x1, x2; \
  )

  # Different operands: 20 - 10 = 10, 15 - 5 = 10
  TEST_CASE( 7, x3, 0x000a000a, \
    li  x1, 0x140f0000; \
    li  x2, 0x0a050000; \
    pwsubu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

