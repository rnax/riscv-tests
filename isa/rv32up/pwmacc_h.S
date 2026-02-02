# See LICENSE for license details.

#*****************************************************************************
# pwmacc_h.S
#-----------------------------------------------------------------------------
#
# Test pwmacc.h instruction (packed widening signed multiply-accumulate halfword).
# Accumulates 16-bit signed multiply results into 32-bit signed values.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: 10 * 20 = 200, 200 + 100 = 300 (0x0000012c)
  TEST_CASE( 2, x3, 0x0000012c, \
    li  x1, 0x00640000; \
    li  x2, 0x000a0000; \
    li  x4, 0x00140000; \
    pwmacc.h x3, x2, x4; \
  )

  # Accumulate with negative: -50 * 40 = -2000, -2000 + 5000 = 3000 (0x00000bb8)
  TEST_CASE( 3, x3, 0x00000bb8, \
    li  x1, 0x13880000; \
    li  x2, 0xffce0000; \
    li  x4, 0x00280000; \
    pwmacc.h x3, x2, x4; \
  )

  # Accumulate negative result: 10 * 10 = 100, 100 + (-200) = -100 (0xffffff9c)
  TEST_CASE( 4, x3, 0xffffff9c, \
    li  x1, 0xffffff380000; \
    li  x2, 0x000a0000; \
    li  x4, 0x000a0000; \
    pwmacc.h x3, x2, x4; \
  )

  # Zero accumulate: 0 * 100 = 0, 0 + 500 = 500 (0x000001f4)
  TEST_CASE( 5, x3, 0x000001f4, \
    li  x1, 0x000001f40000; \
    li  x2, 0x00000000; \
    li  x4, 0x00640000; \
    pwmacc.h x3, x2, x4; \
  )

  # Accumulate zero: 50 * 50 = 2500, 2500 + 0 = 2500 (0x000009c4)
  TEST_CASE( 6, x3, 0x000009c4, \
    li  x1, 0x00000000; \
    li  x2, 0x00320000; \
    li  x4, 0x00320000; \
    pwmacc.h x3, x2, x4; \
  )

  # Different operands: 15 * 20 = 300, 300 + 200 = 500 (0x000001f4)
  TEST_CASE( 7, x3, 0x000001f4, \
    li  x1, 0x000000c80000; \
    li  x2, 0x000f0000; \
    li  x4, 0x00140000; \
    pwmacc.h x3, x2, x4; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

