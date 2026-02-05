# See LICENSE for license details.

#*****************************************************************************
# wmulsu.S
#-----------------------------------------------------------------------------
#
# Test wmulsu instruction (widening signed*unsigned multiply).
# rd:rd+1 = rs1 * (unsigned)rs2 (64-bit result from 32x32 signed*unsigned multiply)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wmulsu rd, rs1, rs2: rd:rd+1 = rs1 * (unsigned)rs2
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000015, \
    li  x10, 0x00000003; \
    li  x12, 0x00000007; \
    wmulsu x14, x10, x12; \
  )

  # Large positive: 0x10000 * 0x10000 = 0x100000000
  TEST_CASE_D32( 3, x14, x15, 0x0000000100000000, \
    li  x10, 0x00010000; \
    li  x12, 0x00010000; \
    wmulsu x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x12, 0x00000000; \
    wmulsu x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

