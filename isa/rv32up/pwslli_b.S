# See LICENSE for license details.

#*****************************************************************************
# pwslli_b.S
#-----------------------------------------------------------------------------
#
# Test pwslli.b instruction (packed widening shift left).
# rd:rd+1 = rs1 << imm element-wise
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (rd is register pair - must be even)
  #-------------------------------------------------------------

  # Basic test - shift left by 0
  TEST_CASE_D32( 2, x14, x15, 0x0404040404040404, \
    li  x10, 0x04040404; \
    pwslli.b x14, x10, 0; \
  )

  # Shift left by 1
  TEST_CASE_D32( 3, x14, x15, 0x0808080808080808, \
    li  x10, 0x04040404; \
    pwslli.b x14, x10, 1; \
  )

  # Zero input
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    pwslli.b x14, x10, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
