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
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0x00000015, 0x00000000, 0x00000003, 0x00000007, x1, 0, x6 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0x00000096, 0x00000000, 0x00000005, 0x0000000a, x1, 0, x6 );
  
  # Signed negative * unsigned: 1000 + (-10) * 20 = 800
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0x00000320, 0x00000000, 0xfffffff6, 0x00000014, x1, 0, x6 );
  
  # Signed negative * unsigned large: 0 + (-1) * 0xFFFFFFFF = -0xFFFFFFFF
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0x00000001, 0xffffffff, 0xffffffff, 0xffffffff, x1, 0, x6 );
  
  # Large accumulation: 0x100000000 + 0x10000 * 0x10000 = 0x200000000
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0x00000000, 0x00000002, 0x00010000, 0x00010000, x1, 0, x6 );
  
  # Negative result: -100 + (-5) * 10 = -150
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0xffffff6a, 0xffffffff, 0xfffffffb, 0x0000000a, x1, 0, x6 );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_P64_PNN_OP( wmaccsu, x2, x3, x4, x5, 0x000001f4, 0x00000000, 0x00000000, 0x00000064, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

