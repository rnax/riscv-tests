# See LICENSE for license details.

#*****************************************************************************
# pwmul_b.S
#-----------------------------------------------------------------------------
#
# Test pwmul.b instruction (packed widening signed multiply byte).
# Multiplies two 8-bit signed values and produces 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x0015 in both bytes)
  TEST_CASE( 2, x3, 0x00150015, \
    li  x1, 0x03070307; \
    pwmul.b x3, x1, x1; \
  )

  # Multiply with larger values: 10 * 10 = 100 (0x0064 in both bytes)
  TEST_CASE( 3, x3, 0x00640064, \
    li  x1, 0x0a0a0a0a; \
    pwmul.b x3, x1, x1; \
  )

  # Negative multiply: -4 * -5 = 20 (0x0014 in both bytes)
  TEST_CASE( 4, x3, 0x00140014, \
    li  x1, 0xfcfbfcfb; \
    pwmul.b x3, x1, x1; \
  )

  # Mixed sign: -3 * 4 = -12 (0xfff4 in both bytes)
  TEST_CASE( 5, x3, 0xfff4fff4, \
    li  x1, 0xfd04fd04; \
    pwmul.b x3, x1, x1; \
  )

  # Zero multiply: 0 * 5 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00050000; \
    pwmul.b x3, x1, x1; \
  )

  # Different operands: 2 * 3 = 6, 5 * 4 = 20
  TEST_CASE( 7, x3, 0x00140006, \
    li  x1, 0x02050000; \
    li  x2, 0x03040000; \
    pwmul.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

