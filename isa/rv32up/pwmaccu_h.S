# See LICENSE for license details.

#*****************************************************************************
# pwmaccu_h.S
#-----------------------------------------------------------------------------
#
# Test pwmaccu.h instruction (packed unsigned widening multiply-accumulate halfword).
# Accumulates 16-bit unsigned multiply results into 32-bit unsigned values.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: 100 * 200 = 20000, 20000 + 10000 = 30000 (0x00007530)
  TEST_CASE( 2, x3, 0x00007530, \
    li  x1, 0x00002710; \
    li  x2, 0x00640000; \
    li  x4, 0x00c80000; \
    pwmaccu.h x3, x2, x4; \
  )

  # Larger accumulate: 500 * 600 = 300000, 300000 + 100000 = 400000 (0x000061a8)
  TEST_CASE( 3, x3, 0x000061a8, \
    li  x1, 0x000186a0; \
    li  x2, 0x01f40000; \
    li  x4, 0x02580000; \
    pwmaccu.h x3, x2, x4; \
  )

  # Max values: 65535 * 65535 = 4294836225, + 1000 = 4294837225 (0xfffe03e8)
  TEST_CASE( 4, x3, 0xfffe03e8, \
    li  x1, 0xfffe00e8; \
    li  x2, 0xffff0000; \
    li  x4, 0xffff0000; \
    pwmaccu.h x3, x2, x4; \
  )

  # Zero multiply: 0 * 1000 = 0, 0 + 5000 = 5000 (0x00001388)
  TEST_CASE( 5, x3, 0x00001388, \
    li  x1, 0x00001388; \
    li  x2, 0x00000000; \
    li  x4, 0x03e80000; \
    pwmaccu.h x3, x2, x4; \
  )

  # Accumulate zero: 256 * 512 = 131072, 131072 + 0 = 131072 (0x00020000)
  TEST_CASE( 6, x3, 0x00020000, \
    li  x1, 0x00000000; \
    li  x2, 0x01000000; \
    li  x4, 0x02000000; \
    pwmaccu.h x3, x2, x4; \
  )

  # Different operands: 1000 * 1000 = 1000000, + 500000 = 1500000 (0x0016e360)
  TEST_CASE( 7, x3, 0x0016e360, \
    li  x1, 0x0007a120; \
    li  x2, 0x03e80000; \
    li  x4, 0x03e80000; \
    pwmaccu.h x3, x2, x4; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

