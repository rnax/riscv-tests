# See LICENSE for license details.

#*****************************************************************************
# pwsuba_b.S
#-----------------------------------------------------------------------------
#
# Test pwsuba.b instruction (packed widening add/sub accumulate).
# rd:rd+1 += rs1 +/- rs2 element-wise
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (rd is register pair - must be even)
  #-------------------------------------------------------------

  # Basic test
  TEST_CASE_D32( 2, x14, x15, 0x0014001400140014, \
    li  x14, 0x000a000a; \
    li  x15, 0x000a000a; \
    li  x10, 0x04040404; \
    li  x12, 0x06060606; \
    pwsuba.b x14, x10, x12; \
  )

  # Zero input
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x12, 0x00000000; \
    pwsuba.b x14, x10, x12; \
  )

  # Pattern test
  TEST_CASE_D32( 4, x14, x15, 0x0010001000100010, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x08080808; \
    li  x12, 0x08080808; \
    pwsuba.b x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
