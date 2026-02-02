# See LICENSE for license details.

#*****************************************************************************
# mulsu_h11.S
#-----------------------------------------------------------------------------
#
# Test mulsu.h11 instruction (multiply signed*unsigned halfword 11).
# rd = sext(rs1[31:16]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mulsu.h11, 0x00000015, 0x00030000, 0x00070000 );
  
  # Multiply with larger values: 100 * 50 = 5000
  TEST_RR_OP( 3,  mulsu.h11, 0x00001388, 0x00640000, 0x00320000 );
  
  # Negative signed, positive unsigned: (-10) * 20 = -200
  TEST_RR_OP( 4,  mulsu.h11, 0xffffff38, 0xfff60000, 0x00140000 );
  
  # Halfword selection (upper 16 bits): 0x1234 * 0x5678 = 0x0a3c4d50
  TEST_RR_OP( 5,  mulsu.h11, 0x0a3c4d50, 0x12340005, 0x56780000 );
  
  # Negative signed, positive unsigned: (-5) * 10 = -50
  TEST_RR_OP( 6,  mulsu.h11, 0xffffffce, 0xfffb0000, 0x000a0000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  mulsu.h11, 0x00000000, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulsu.h11, 21, 0x00030000, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulsu.h11, 35, 0x00050000, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

