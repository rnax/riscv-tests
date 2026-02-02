# See LICENSE for license details.

#*****************************************************************************
# pwmulsu_b.S
#-----------------------------------------------------------------------------
#
# Test pwmulsu.b instruction (packed widening signed*unsigned multiply byte).
# Multiplies 8-bit signed by 8-bit unsigned and produces 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive signed * positive unsigned: 5 * 6 = 30 (0x001e)
  TEST_CASE( 2, x3, 0x001e001e, \
    li  x1, 0x05060506; \
    li  x2, 0x06070607; \
    pwmulsu.b x3, x1, x2; \
  )

  # Negative signed * positive unsigned: -4 * 10 = -40 (0xffd8)
  TEST_CASE( 3, x3, 0xffd8ffd8, \
    li  x1, 0xfcfdfcfd; \
    li  x2, 0x0a0b0a0b; \
    pwmulsu.b x3, x1, x2; \
  )

  # Positive signed * max unsigned: 10 * 255 = 2550 (0x0a06)
  TEST_CASE( 4, x3, 0x0a060a06, \
    li  x1, 0x0a0b0a0b; \
    li  x2, 0xffffffff; \
    pwmulsu.b x3, x1, x2; \
  )

  # Negative signed * max unsigned: -1 * 255 = -255 (0xff01)
  TEST_CASE( 5, x3, 0xff01ff01, \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pwmulsu.b x3, x1, x2; \
  )

  # Zero multiply: 0 * 100 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x64650000; \
    pwmulsu.b x3, x1, x2; \
  )

  # Different operands: 3 * 7 = 21, -2 * 8 = -16
  TEST_CASE( 7, x3, 0xfff00015, \
    li  x1, 0x03fe0000; \
    li  x2, 0x07080000; \
    pwmulsu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

