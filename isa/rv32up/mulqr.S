# See LICENSE for license details.

#*****************************************************************************
# mulqr.S
#-----------------------------------------------------------------------------
#
# Test mulqr instruction (Q-format multiply with rounding).
# rd = (((rs1 * rs2) >> 30) + 1) >> 1, with saturation for INT32_MIN * INT32_MIN
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x00010000 = 0x0000000100000000, rounded Q-format = 1
  TEST_RR_OP( 2,  mulqr, 0x00000001, 0x00010000, 0x00010000 );
  
  # Multiply with larger values: 0x00100000 * 0x00100000 = 0x0010000000000000, rounded Q-format = 0x1000
  TEST_RR_OP( 3,  mulqr, 0x00001000, 0x00100000, 0x00100000 );
  
  # Negative multiply: 0xffffffff * 0xffffffff = 0x0000000100000001, rounded Q-format = 1
  TEST_RR_OP( 4,  mulqr, 0x00000001, 0xffffffff, 0xffffffff );
  
  # Positive and negative: 0x00010000 * 0xffffffff = 0xffffffff00010000, rounded Q-format = 0xffffffff
  TEST_RR_OP( 5,  mulqr, 0xffffffff, 0x00010000, 0xffffffff );
  
  # Small values: 0x00000003 * 0x00000007 = 0x00000015, rounded Q-format = 0
  TEST_RR_OP( 6,  mulqr, 0x00000000, 0x00000003, 0x00000007 );
  
  # Saturation case: INT32_MIN * INT32_MIN = INT32_MAX
  TEST_RR_OP( 7,  mulqr, 0x7fffffff, 0x80000000, 0x80000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulqr, 1, 0x00010000, 0x00010000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulqr, 1, 0x00010000, 0x00010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

