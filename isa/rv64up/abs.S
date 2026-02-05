# See LICENSE for license details.

#*****************************************************************************
# abs.S
#-----------------------------------------------------------------------------
#
# Test abs instruction (absolute value).
# rd = |rs1|
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive value: |5| = 5
  TEST_R_OP( 2,  abs, 0x00000005, 0x00000005 );
  
  # Negative value: |-5| = 5
  TEST_R_OP( 3,  abs, 0x00000005, 0xfffffffb );
  
  # Zero: |0| = 0
  TEST_R_OP( 4,  abs, 0x00000000, 0x00000000 );
  
  # Min int (special case): |0x80000000| = 0x80000000 (saturates)
  TEST_R_OP( 5,  abs, 0x80000000, 0x80000000 );
  
  # Max int: |0x7FFFFFFF| = 0x7FFFFFFF
  TEST_R_OP( 6,  abs, 0x7fffffff, 0x7fffffff );
  
  # Large negative: |-1000| = 1000
  TEST_R_OP( 7,  abs, 0x000003e8, 0xfffffc18 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_R_SRC1_EQ_DEST( 8, abs, 5, 5 );
  TEST_R_SRC1_EQ_DEST( 9, abs, 10, -10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_R_DEST_BYPASS( 10, 0, abs, 5, 5 );
  TEST_R_DEST_BYPASS( 11, 1, abs, 10, -10 );
  TEST_R_DEST_BYPASS( 12, 2, abs, 100, -100 );

  TEST_R_SRC1_BYPASS( 13, 0, abs, 5, 5 );
  TEST_R_SRC1_BYPASS( 14, 1, abs, 10, -10 );
  TEST_R_SRC1_BYPASS( 15, 2, abs, 100, -100 );

  TEST_R_ZEROSRC1( 16, abs, 0 );
  TEST_R_ZERODEST( 17, abs, 5 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

