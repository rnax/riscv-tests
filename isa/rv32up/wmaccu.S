# See LICENSE for license details.

#*****************************************************************************
# wmaccu.S
#-----------------------------------------------------------------------------
#
# Test wmaccu instruction (widening multiply-accumulate unsigned).
# rd:rd+1 = rd:rd+1 + (unsigned)rs1 * (unsigned)rs2 (64-bit unsigned accumulation)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0x00000015, 0x00000000, 0x00000003, 0x00000007, x1, 0, x6 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0x00000096, 0x00000000, 0x00000005, 0x0000000a, x1, 0, x6 );
  
  # Unsigned interpretation: 0xFFFFFFFF + 0xFFFFFFFF * 0xFFFFFFFF = 0xFFFFFFFE00000000
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0x00000000, 0xfffffffe, 0xffffffff, 0xffffffff, x1, 0, x6 );
  
  # Large accumulation: 0x100000000 + 0x10000 * 0x10000 = 0x200000000
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0x00000000, 0x00000002, 0x00010000, 0x00010000, x1, 0, x6 );
  
  # Unsigned large multiply: 0x80000000 + 0x80000000 * 2 = 0x180000000
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0x00000000, 0x00000001, 0x80000000, 0x00000002, x1, 0, x6 );
  
  # Accumulate with unsigned: 0x200000000 + 0xFFFFFFFF * 2 = 0x3FFFFFFFE
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0xfffffffe, 0x00000003, 0xffffffff, 0x00000002, x1, 0, x6 );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_P64_PNN_OP( wmaccu, x2, x3, x4, x5, 0x000001f4, 0x00000000, 0x00000000, 0x00000064, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

