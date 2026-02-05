# See LICENSE for license details.

#*****************************************************************************
# wmaccsu.S
#-----------------------------------------------------------------------------
#
# Test wmaccsu instruction (widening multiply-accumulate signed*unsigned).
# rd:rd+1 = rd:rd+1 + rs1 * (unsigned)rs2 (64-bit signed*unsigned accumulation)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wmaccsu rd, rs1, rs2: rd:rd+1 += rs1 * (unsigned)rs2
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000015, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x00000003; \
    li  x12, 0x00000007; \
    wmaccsu x14, x10, x12; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000096, \
    li  x14, 0x00000064; \
    li  x15, 0x00000000; \
    li  x10, 0x00000005; \
    li  x12, 0x0000000a; \
    wmaccsu x14, x10, x12; \
  )

  # Zero multiply: 500 + 0 * 100 = 500
  TEST_CASE_D32( 4, x14, x15, 0x00000000000001f4, \
    li  x14, 0x000001f4; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x12, 0x00000064; \
    wmaccsu x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

