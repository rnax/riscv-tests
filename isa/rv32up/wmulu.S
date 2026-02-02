# See LICENSE for license details.

#*****************************************************************************
# wmulu.S
#-----------------------------------------------------------------------------
#
# Test wmulu instruction (widening unsigned multiply).
# rd:rd+1 = (unsigned)rs1 * (unsigned)rs2 (64-bit result from 32x32 unsigned multiply)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000015, 0x00000000, 0x00000003, 0x00000007, x1, 0, x6 );
  
  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00004e20, 0x00000000, 0x00000064, 0x000000c8, x1, 0, x6 );
  
  # Unsigned interpretation: 0xFFFFFFFF * 0xFFFFFFFF = 0xFFFFFFFE00000001
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000001, 0xfffffffe, 0xffffffff, 0xffffffff, x1, 0, x6 );
  
  # 0x80000000 * 2 = 0x100000000
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000000, 0x00000001, 0x80000000, 0x00000002, x1, 0, x6 );
  
  # Large unsigned: 0x10000 * 0x10000 = 0x100000000
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000000, 0x00000001, 0x00010000, 0x00010000, x1, 0, x6 );
  
  # Max unsigned * 1: 0xFFFFFFFF * 1 = 0xFFFFFFFF
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0xffffffff, 0x00000000, 0xffffffff, 0x00000001, x1, 0, x6 );
  
  # 0xFFFFFFFF * 0xFFFFFFFF = 0xFFFFFFFE00000001
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000001, 0xfffffffe, 0xffffffff, 0xffffffff, x1, 0, x6 );
  
  # Zero cases
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, x1, 0, x6 );
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000000, 0x00000000, 0x00000000, 0xffffffff, x1, 0, x6 );
  TEST_P64_PNN_OP( wmulu, x2, x3, x4, x5, 0x00000000, 0x00000000, 0xffffffff, 0x00000000, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

