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
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x00000015, 0x00000000, 0x00000003, 0x00000007, x1, 0, x6 );
  
  # Signed negative * unsigned: -5 * 10 = -50
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0xffffffce, 0xffffffff, 0xfffffffb, 0x0000000a, x1, 0, x6 );
  
  # Signed negative * unsigned large: -1 * 0xFFFFFFFF = -0xFFFFFFFF
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x00000001, 0xffffffff, 0xffffffff, 0xffffffff, x1, 0, x6 );
  
  # Signed positive * unsigned large: 2 * 0xFFFFFFFF = 0x1FFFFFFFE
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0xfffffffe, 0x00000001, 0x00000002, 0xffffffff, x1, 0, x6 );
  
  # Signed min * unsigned: 0x80000000 * 2 = 0xFFFFFFFF00000000
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x00000000, 0xffffffff, 0x80000000, 0x00000002, x1, 0, x6 );
  
  # Signed max * unsigned: 0x7FFFFFFF * 0xFFFFFFFF = 0x7FFFFFFE80000001
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x80000001, 0x7ffffffe, 0x7fffffff, 0xffffffff, x1, 0, x6 );
  
  # Zero cases
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, x1, 0, x6 );
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x00000000, 0x00000000, 0xffffffff, 0x00000000, x1, 0, x6 );
  TEST_P64_PNN_OP( wmulsu, x2, x3, x4, x5, 0x00000000, 0x00000000, 0x00000000, 0xffffffff, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

