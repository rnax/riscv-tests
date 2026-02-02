# See LICENSE for license details.

#*****************************************************************************
# pwmulu_b.S
#-----------------------------------------------------------------------------
#
# Test pwmulu.b instruction (packed widening unsigned multiply byte).
# Multiplies two 8-bit unsigned values and produces 16-bit unsigned results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 5 * 6 = 30 (0x001e in both bytes)
  TEST_CASE( 2, x3, 0x001e001e, \
    li  x1, 0x05060506; \
    pwmulu.b x3, x1, x1; \
  )

  # Larger values: 15 * 16 = 240 (0x00f0 in both bytes)
  TEST_CASE( 3, x3, 0x00f000f0, \
    li  x1, 0x0f100f10; \
    pwmulu.b x3, x1, x1; \
  )

  # Max byte values: 255 * 255 = 65025 (0xfe01 in both bytes)
  TEST_CASE( 4, x3, 0xfe01fe01, \
    li  x1, 0xffffffff; \
    pwmulu.b x3, x1, x1; \
  )

  # Mixed values: 10 * 20 = 200 (0x00c8)
  TEST_CASE( 5, x3, 0x00c800c8, \
    li  x1, 0x0a140a14; \
    pwmulu.b x3, x1, x1; \
  )

  # Zero multiply: 0 * 255 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00ff0000; \
    pwmulu.b x3, x1, x1; \
  )

  # Different operands: 7 * 8 = 56, 9 * 11 = 99
  TEST_CASE( 7, x3, 0x00630038, \
    li  x1, 0x07090000; \
    li  x2, 0x080b0000; \
    pwmulu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

