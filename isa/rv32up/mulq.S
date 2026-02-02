# See LICENSE for license details.

#*****************************************************************************
# mulq.S
#-----------------------------------------------------------------------------
#
# Test mulq instruction (Q-format multiply).
# rd = (rs1 * rs2) >> 31, with saturation for INT32_MIN * INT32_MIN
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x00010000 = 0x0000000100000000, Q-format = 2
  TEST_RR_OP( 2,  mulq, 0x00000002, 0x00010000, 0x00010000 );
  
  # Multiply with larger values: 0x00100000 * 0x00100000 = 0x0010000000000000, Q-format = 0x2000
  TEST_RR_OP( 3,  mulq, 0x00002000, 0x00100000, 0x00100000 );
  
  # Negative multiply: 0xffffffff * 0xffffffff = 0x0000000100000001, Q-format = 2
  TEST_RR_OP( 4,  mulq, 0x00000002, 0xffffffff, 0xffffffff );
  
  # Positive and negative: 0x00010000 * 0xffffffff = 0xffffffff00010000, Q-format = 0xfffffffe
  TEST_RR_OP( 5,  mulq, 0xfffffffe, 0x00010000, 0xffffffff );
  
  # Small values: 0x00000003 * 0x00000007 = 0x00000015, Q-format = 0
  TEST_RR_OP( 6,  mulq, 0x00000000, 0x00000003, 0x00000007 );
  
  # Saturation case: INT32_MIN * INT32_MIN = INT32_MAX
  TEST_RR_OP( 7,  mulq, 0x7fffffff, 0x80000000, 0x80000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulq, 2, 0x00010000, 0x00010000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulq, 2, 0x00010000, 0x00010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

