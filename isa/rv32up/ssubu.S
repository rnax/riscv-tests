# See LICENSE for license details.

#*****************************************************************************
# ssubu.S
#-----------------------------------------------------------------------------
#
# Test ssubu instruction (unsigned saturating subtract).
# rd = SAT(rs1 - rs2) [unsigned]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 5 - 3 = 2
  TEST_RR_OP( 2,  ssubu, 0x00000002, 0x00000005, 0x00000003 );
  # 20 - 10 = 10
  TEST_RR_OP( 3,  ssubu, 0x0000000a, 0x00000014, 0x0000000a );
  
  # Saturation at min: 0 - 1 saturates to 0
  TEST_RR_OP( 4,  ssubu, 0x00000000, 0x00000000, 0x00000001 );
  # Saturation: 5 - 10 saturates to 0
  TEST_RR_OP( 5,  ssubu, 0x00000000, 0x00000005, 0x0000000a );
  # Saturation: 0x80000000 - 0xFFFFFFFF saturates to 0
  TEST_RR_OP( 6,  ssubu, 0x00000000, 0x80000000, 0xffffffff );
  
  # No saturation: 0xFFFFFFFF - 0x7FFFFFFF = 0x80000000
  TEST_RR_OP( 7,  ssubu, 0x80000000, 0xffffffff, 0x7fffffff );
  
  # Zero cases
  TEST_RR_OP( 8,  ssubu, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 9,  ssubu, 0x00000005, 0x00000005, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, ssubu, 2, 5, 3 );
  TEST_RR_SRC2_EQ_DEST( 11, ssubu, 1, 4, 3 );
  TEST_RR_SRC12_EQ_DEST( 12, ssubu, 0, 5 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, ssubu, 2, 5, 3 );
  TEST_RR_DEST_BYPASS( 14, 1, ssubu, 1, 4, 3 );
  TEST_RR_DEST_BYPASS( 15, 2, ssubu, 0, 3, 3 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, ssubu, 2, 5, 3 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, ssubu, 1, 4, 3 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, ssubu, 0, 3, 3 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, ssubu, 2, 5, 3 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, ssubu, 1, 4, 3 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, ssubu, 0, 3, 3 );

  TEST_RR_ZEROSRC1( 22, ssubu, 0, 5 );
  TEST_RR_ZEROSRC2( 23, ssubu, 5, 5 );
  TEST_RR_ZEROSRC12( 24, ssubu, 0 );
  TEST_RR_ZERODEST( 25, ssubu, 5, 3 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

