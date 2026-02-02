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
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x00000015, 0x00000000, 0x00000003, 0x00000007, x1, 0, x6 );
  
  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x00004e20, 0x00000000, 0x00000064, 0x000000c8, x1, 0, x6 );
  
  # Negative * Positive: -5 * 10 = -50
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0xffffffce, 0xffffffff, 0xfffffffb, 0x0000000a, x1, 0, x6 );
  
  # Negative * Negative: -10 * -20 = 200
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x000000c8, 0x00000000, 0xfffffff6, 0xffffffec, x1, 0, x6 );
  
  # Large positive multiply: 0x10000 * 0x10000 = 0x100000000
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x00000000, 0x00000001, 0x00010000, 0x00010000, x1, 0, x6 );
  
  # Max positive * 1: 0x7FFFFFFF * 1 = 0x7FFFFFFF
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x7fffffff, 0x00000000, 0x7fffffff, 0x00000001, x1, 0, x6 );
  
  # Min negative * 1: 0x80000000 * 1 = 0xFFFFFFFF80000000
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x80000000, 0xffffffff, 0x80000000, 0x00000001, x1, 0, x6 );
  
  # Zero cases
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, x1, 0, x6 );
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x00000000, 0x00000000, 0x00000000, 0x12345678, x1, 0, x6 );
  TEST_P64_PNN_OP( wmul, x2, x3, x4, x5, 0x00000000, 0x00000000, 0xffffffff, 0x00000000, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

