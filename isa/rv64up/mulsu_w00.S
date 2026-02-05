# See LICENSE for license details.

#*****************************************************************************
# mulsu_w00.S
#-----------------------------------------------------------------------------
#
# Test mulsu.w00 instruction (multiply signed*unsigned word bottom-bottom).
# rd = sext(rs1[31:0]) * zext(rs2[31:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mulsu.w00, 0x0000000000000015, 0x0000000000000003, 0x0000000000000007 );
  
  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_RR_OP( 3,  mulsu.w00, 0x0000000000004e20, 0x0000000000000064, 0x00000000000000c8 );
  
  # Signed negative * unsigned: -5 * 10 = -50
  TEST_RR_OP( 4,  mulsu.w00, 0xffffffffffffffce, 0xfffffffffffffffb, 0x000000000000000a );
  
  # Signed negative * unsigned large: -1 * 0xffffffff = -0xffffffff
  TEST_RR_OP( 5,  mulsu.w00, 0xffffffff00000001, 0xffffffffffffffff, 0x00000000ffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 6,  mulsu.w00, 0x0000000000000000, 0x0000000000000000, 0x0000000000000064 );
  
  # Max 32-bit signed * max unsigned: 0x7fffffff * 0xffffffff
  TEST_RR_OP( 7,  mulsu.w00, 0x7ffffffe80000001, 0x000000007fffffff, 0x00000000ffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulsu.w00, 0x0000000000000015, 3, 7 );
  TEST_RR_SRC2_EQ_DEST( 9, mulsu.w00, 0x0000000000000023, 5, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

