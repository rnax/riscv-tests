# See LICENSE for license details.

#*****************************************************************************
# pwsubu_h.S
#-----------------------------------------------------------------------------
#
# Test pwsubu.h instruction (packed widening unsigned subtract halfword).
# Subtracts two 16-bit unsigned values and produces 32-bit unsigned results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening subtract: 0x000a - 0x0004 = 0x00000006
  TEST_CASE( 2, x3, 0x00000006, \
    li  x1, 0x000a0000; \
    li  x2, 0x00040000; \
    pwsubu.h x3, x1, x2; \
  )

  # Widening subtract with borrow: 0x0004 - 0x000a = -6 (0xfffffffa, unsigned wraps)
  TEST_CASE( 3, x3, 0xfffffffa, \
    li  x1, 0x00040000; \
    li  x2, 0x000a0000; \
    pwsubu.h x3, x1, x2; \
  )

  # Unsigned subtract: 0x8000 - 0x8000 = 0
  TEST_CASE( 4, x3, 0x00000000, \
    li  x1, 0x80000000; \
    li  x2, 0x80000000; \
    pwsubu.h x3, x1, x2; \
  )

  # Unsigned subtract: 0xffff - 0x0000 = 0x0000ffff
  TEST_CASE( 5, x3, 0x0000ffff, \
    li  x1, 0xffff0000; \
    li  x2, 0x00000000; \
    pwsubu.h x3, x1, x2; \
  )

  # Zero subtract: 0 - 0 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x00000000; \
    pwsubu.h x3, x1, x2; \
  )

  # Different operands: 0x0014 - 0x000a = 0x0000000a
  TEST_CASE( 7, x3, 0x0000000a, \
    li  x1, 0x00140000; \
    li  x2, 0x000a0000; \
    pwsubu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

