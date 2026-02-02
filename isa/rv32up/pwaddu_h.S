# See LICENSE for license details.

#*****************************************************************************
# pwaddu_h.S
#-----------------------------------------------------------------------------
#
# Test pwaddu.h instruction (packed widening unsigned add halfword).
# Adds two 16-bit unsigned values and produces 32-bit unsigned results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening add: 0x0004 + 0x0006 = 0x0000000a
  TEST_CASE( 2, x3, 0x0000000a, \
    li  x1, 0x00040006; \
    pwaddu.h x3, x1, x1; \
  )

  # Widening add with larger values: 0xffff + 0xffff = 0x0001fffe
  TEST_CASE( 3, x3, 0x0001fffe, \
    li  x1, 0xffffffff; \
    pwaddu.h x3, x1, x1; \
  )

  # Widening add: 0x8000 + 0x8000 = 0x00010000
  TEST_CASE( 4, x3, 0x00010000, \
    li  x1, 0x80008000; \
    pwaddu.h x3, x1, x1; \
  )

  # Mixed values: 0x0000 + 0xffff = 0x0000ffff
  TEST_CASE( 5, x3, 0x0000ffff, \
    li  x1, 0x0000ffff; \
    pwaddu.h x3, x1, x1; \
  )

  # Zero cases
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    pwaddu.h x3, x1, x1; \
  )

  # Different operands: 0x000a + 0x0014 = 0x0000001e
  TEST_CASE( 7, x3, 0x0000001e, \
    li  x1, 0x000a0000; \
    li  x2, 0x00140000; \
    pwaddu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

