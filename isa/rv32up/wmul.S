# See LICENSE for license details.

#*****************************************************************************
# wmul.S
#-----------------------------------------------------------------------------
#
# Test wmul instruction (widening signed multiply).
# rd:rd+1 = rs1 * rs2 (64-bit result from 32x32 signed multiply)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wmul rd, rs1, rs2: rd:rd+1 = rs1 * rs2 (signed 64-bit result)
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000015, \
    li  x10, 0x00000003; \
    li  x12, 0x00000007; \
    wmul x14, x10, x12; \
  )

  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000004e20, \
    li  x10, 0x00000064; \
    li  x12, 0x000000c8; \
    wmul x14, x10, x12; \
  )

  # Negative * Positive: -5 * 10 = -50
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffce, \
    li  x10, 0xfffffffb; \
    li  x12, 0x0000000a; \
    wmul x14, x10, x12; \
  )

  # Negative * Negative: -10 * -20 = 200
  TEST_CASE_D32( 5, x14, x15, 0x00000000000000c8, \
    li  x10, 0xfffffff6; \
    li  x12, 0xffffffec; \
    wmul x14, x10, x12; \
  )

  # Large positive multiply: 0x10000 * 0x10000 = 0x100000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000100000000, \
    li  x10, 0x00010000; \
    li  x12, 0x00010000; \
    wmul x14, x10, x12; \
  )

  # Max positive * 1: 0x7FFFFFFF * 1 = 0x7FFFFFFF
  TEST_CASE_D32( 7, x14, x15, 0x000000007fffffff, \
    li  x10, 0x7fffffff; \
    li  x12, 0x00000001; \
    wmul x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

