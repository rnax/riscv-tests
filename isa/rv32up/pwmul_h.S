# See LICENSE for license details.

#*****************************************************************************
# pwmul_h.S
#-----------------------------------------------------------------------------
#
# Test pwmul.h instruction (packed widening signed multiply halfword).
# Multiplies two 16-bit signed values and produces 32-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 10 * 20 = 200 (0x000000c8)
  TEST_CASE( 2, x3, 0x000000c8, \
    li  x1, 0x000a0000; \
    li  x2, 0x00140000; \
    pwmul.h x3, x1, x2; \
  )

  # Larger multiply: 100 * 100 = 10000 (0x00002710)
  TEST_CASE( 3, x3, 0x00002710, \
    li  x1, 0x00640000; \
    pwmul.h x3, x1, x1; \
  )

  # Negative multiply: -50 * -40 = 2000 (0x000007d0)
  TEST_CASE( 4, x3, 0x000007d0, \
    li  x1, 0xffce0000; \
    li  x2, 0xffd80000; \
    pwmul.h x3, x1, x2; \
  )

  # Mixed sign: -100 * 50 = -5000 (0xffffec78)
  TEST_CASE( 5, x3, 0xffffec78, \
    li  x1, 0xff9c0000; \
    li  x2, 0x00320000; \
    pwmul.h x3, x1, x2; \
  )

  # Zero multiply: 0 * 100 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x00640000; \
    pwmul.h x3, x1, x2; \
  )

  # Different operands: 15 * 20 = 300 (0x0000012c)
  TEST_CASE( 7, x3, 0x0000012c, \
    li  x1, 0x000f0000; \
    li  x2, 0x00140000; \
    pwmul.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

