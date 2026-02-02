# See LICENSE for license details.

#*****************************************************************************
# pwmaccsu_h.S
#-----------------------------------------------------------------------------
#
# Test pwmaccsu.h instruction (packed signed*unsigned widening multiply-accumulate).
# Accumulates 16-bit signed*unsigned multiply results into 32-bit signed values.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive signed * unsigned: 100 * 200 = 20000, + 5000 = 25000 (0x000061a8)
  TEST_CASE( 2, x3, 0x000061a8, \
    li  x1, 0x00006170; \
    li  x2, 0x00640000; \
    li  x4, 0x00c80000; \
    pwmaccsu.h x3, x2, x4; \
  )

  # Negative signed * unsigned: -100 * 200 = -20000, + 30000 = 10000 (0x00002710)
  TEST_CASE( 3, x3, 0x00002710, \
    li  x1, 0x00007530; \
    li  x2, 0xff9c0000; \
    li  x4, 0x00c80000; \
    pwmaccsu.h x3, x2, x4; \
  )

  # Negative result: 50 * 100 = 5000, + (-10000) = -5000 (0xffffec78)
  TEST_CASE( 4, x3, 0xffffec78, \
    li  x1, 0xffffd8f0; \
    li  x2, 0x00320000; \
    li  x4, 0x00640000; \
    pwmaccsu.h x3, x2, x4; \
  )

  # Zero multiply: 0 * 1000 = 0, + 500 = 500 (0x000001f4)
  TEST_CASE( 5, x3, 0x000001f4, \
    li  x1, 0x000001f4; \
    li  x2, 0x00000000; \
    li  x4, 0x03e80000; \
    pwmaccsu.h x3, x2, x4; \
  )

  # Accumulate zero: -50 * 100 = -5000, + 0 = -5000 (0xffffec78)
  TEST_CASE( 6, x3, 0xffffec78, \
    li  x1, 0x00000000; \
    li  x2, 0xffce0000; \
    li  x4, 0x00640000; \
    pwmaccsu.h x3, x2, x4; \
  )

  # Different operands: 200 * 300 = 60000, + 40000 = 100000 (0x000186a0)
  TEST_CASE( 7, x3, 0x000186a0, \
    li  x1, 0x00009c40; \
    li  x2, 0x00c80000; \
    li  x4, 0x012c0000; \
    pwmaccsu.h x3, x2, x4; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

