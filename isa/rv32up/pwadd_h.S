# See LICENSE for license details.

#*****************************************************************************
# pwadd_h.S
#-----------------------------------------------------------------------------
#
# Test pwadd.h instruction (packed widening signed add halfword).
# Adds two 16-bit signed values and produces 32-bit signed results.
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
    pwadd.h x3, x1, x1; \
  )

  # Widening add with larger values: 0x7fff + 0x7fff = 0x0000fffe
  TEST_CASE( 3, x3, 0x0000fffe, \
    li  x1, 0x7fff7fff; \
    pwadd.h x3, x1, x1; \
  )

  # Negative widening add: -4 + -6 = -10 (0xfffffff6)
  TEST_CASE( 4, x3, 0xfffffff6, \
    li  x1, 0xfffcfffa; \
    pwadd.h x3, x1, x1; \
  )

  # Mixed sign: -1 + 1 = 0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x1, 0xffff0001; \
    pwadd.h x3, x1, x1; \
  )

  # Zero cases
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    pwadd.h x3, x1, x1; \
  )

  # Different operands: 0x000a + 0x0014 = 0x0000001e
  TEST_CASE( 7, x3, 0x0000001e, \
    li  x1, 0x000a0000; \
    li  x2, 0x00140000; \
    pwadd.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

