# See LICENSE for license details.

#*****************************************************************************
# wmacc.S
#-----------------------------------------------------------------------------
#
# Test wmacc instruction (widening multiply-accumulate signed).
# rd:rd+1 = rd:rd+1 + rs1 * rs2 (64-bit accumulation)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0x00000015, 0x00000000, 0x00000003, 0x00000007, x1, 0, x6 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0x00000096, 0x00000000, 0x00000005, 0x0000000a, x1, 0, x6 );
  
  # Negative accumulation: 1000 + (-10) * 20 = 800
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0x00000320, 0x00000000, 0xfffffff6, 0x00000014, x1, 0, x6 );
  
  # Large accumulation: 0x100000000 + 0x10000 * 0x10000 = 0x200000000
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0x00000000, 0x00000002, 0x00010000, 0x00010000, x1, 0, x6 );
  
  # Negative result: -100 + (-5) * 10 = -150
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0xffffff6a, 0xffffffff, 0xfffffffb, 0x0000000a, x1, 0, x6 );
  
  # Accumulate negative: -1000 + 10 * 20 = -800
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0xfffffd00, 0xffffffff, 0x0000000a, 0x00000014, x1, 0, x6 );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_P64_PNN_OP( wmacc, x2, x3, x4, x5, 0x000001f4, 0x00000000, 0x00000000, 0x00000064, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

