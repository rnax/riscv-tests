# See LICENSE for license details.

#*****************************************************************************
# pwmulsu_h.S
#-----------------------------------------------------------------------------
#
# Test pwmulsu.h instruction (packed widening signed*unsigned multiply halfword).
# Multiplies 16-bit signed by 16-bit unsigned and produces 32-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive signed * positive unsigned: 100 * 200 = 20000 (0x00004e20)
  TEST_CASE( 2, x3, 0x00004e20, \
    li  x1, 0x00640000; \
    li  x2, 0x00c80000; \
    pwmulsu.h x3, x1, x2; \
  )

  # Negative signed * positive unsigned: -100 * 200 = -20000 (0xffffb1e0)
  TEST_CASE( 3, x3, 0xffffb1e0, \
    li  x1, 0xff9c0000; \
    li  x2, 0x00c80000; \
    pwmulsu.h x3, x1, x2; \
  )

  # Positive signed * max unsigned: 500 * 65535 = 32767500 (0x01f4ffdc)
  TEST_CASE( 4, x3, 0x01f4ffdc, \
    li  x1, 0x01f40000; \
    li  x2, 0xffff0000; \
    pwmulsu.h x3, x1, x2; \
  )

  # Negative signed * max unsigned: -1 * 65535 = -65535 (0xffff0001)
  TEST_CASE( 5, x3, 0xffff0001, \
    li  x1, 0xffff0000; \
    li  x2, 0xffff0000; \
    pwmulsu.h x3, x1, x2; \
  )

  # Zero multiply: 0 * 1000 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x03e80000; \
    pwmulsu.h x3, x1, x2; \
  )

  # Different operands: 50 * 100 = 5000, -50 * 100 = -5000
  TEST_CASE( 7, x3, 0xffffec78, \
    li  x1, 0xffce0000; \
    li  x2, 0x00640000; \
    pwmulsu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

