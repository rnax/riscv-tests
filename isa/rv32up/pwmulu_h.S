# See LICENSE for license details.

#*****************************************************************************
# pwmulu_h.S
#-----------------------------------------------------------------------------
#
# Test pwmulu.h instruction (packed widening unsigned multiply halfword).
# Multiplies two 16-bit unsigned values and produces 32-bit unsigned results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 100 * 200 = 20000 (0x00004e20)
  TEST_CASE( 2, x3, 0x00004e20, \
    li  x1, 0x00640000; \
    li  x2, 0x00c80000; \
    pwmulu.h x3, x1, x2; \
  )

  # Larger multiply: 1000 * 1000 = 1000000 (0x000f4240)
  TEST_CASE( 3, x3, 0x000f4240, \
    li  x1, 0x03e80000; \
    pwmulu.h x3, x1, x1; \
  )

  # Max halfword: 65535 * 65535 = 4294836225 (0xfffe0001)
  TEST_CASE( 4, x3, 0xfffe0001, \
    li  x1, 0xffff0000; \
    pwmulu.h x3, x1, x1; \
  )

  # Mixed values: 500 * 600 = 300000 (0x00049680)
  TEST_CASE( 5, x3, 0x00049680, \
    li  x1, 0x01f40000; \
    li  x2, 0x02580000; \
    pwmulu.h x3, x1, x2; \
  )

  # Zero multiply: 0 * 65535 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0xffff0000; \
    pwmulu.h x3, x1, x2; \
  )

  # Different operands: 256 * 512 = 131072 (0x00020000)
  TEST_CASE( 7, x3, 0x00020000, \
    li  x1, 0x01000000; \
    li  x2, 0x02000000; \
    pwmulu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

