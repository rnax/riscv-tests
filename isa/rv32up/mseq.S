# See LICENSE for license details.

#*****************************************************************************
# mseq.S
#-----------------------------------------------------------------------------
#
# Test mseq instruction (mask equal).
# rd = (rs1 == rs2) ? -1 : 0
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Equal cases (result = 0xFFFFFFFF)
  TEST_RR_OP( 2,  mseq, 0xffffffff, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  mseq, 0xffffffff, 0x00000001, 0x00000001 );
  TEST_RR_OP( 4,  mseq, 0xffffffff, 0x0000000a, 0x0000000a );
  
  # Not equal cases (result = 0x00000000)
  TEST_RR_OP( 5,  mseq, 0x00000000, 0x00000000, 0x00000001 );
  TEST_RR_OP( 6,  mseq, 0x00000000, 0x00000001, 0x00000002 );
  TEST_RR_OP( 7,  mseq, 0x00000000, 0x0000000a, 0x00000014 );
  
  # Negative numbers equal
  TEST_RR_OP( 8,  mseq, 0xffffffff, 0xffffffff, 0xffffffff );
  TEST_RR_OP( 9,  mseq, 0xffffffff, 0xfffffffc, 0xfffffffc );
  
  # Negative numbers not equal
  TEST_RR_OP( 10, mseq, 0x00000000, 0xffffffff, 0x00000000 );
  TEST_RR_OP( 11, mseq, 0x00000000, 0xfffffffc, 0xfffffffd );
  
  # Boundary values equal
  TEST_RR_OP( 12, mseq, 0xffffffff, 0x7fffffff, 0x7fffffff );
  TEST_RR_OP( 13, mseq, 0xffffffff, 0x80000000, 0x80000000 );
  
  # Boundary values not equal
  TEST_RR_OP( 14, mseq, 0x00000000, 0x7fffffff, 0x80000000 );
  TEST_RR_OP( 15, mseq, 0x00000000, 0x80000000, 0x7fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 16, mseq, 0xffffffff, 5, 5 );
  TEST_RR_SRC2_EQ_DEST( 17, mseq, 0xffffffff, 7, 7 );
  TEST_RR_SRC12_EQ_DEST( 18, mseq, 0xffffffff, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 19, 0, mseq, 0xffffffff, 5, 5 );
  TEST_RR_DEST_BYPASS( 20, 1, mseq, 0xffffffff, 7, 7 );
  TEST_RR_DEST_BYPASS( 21, 2, mseq, 0x00000000, 9, 10 );

  TEST_RR_SRC12_BYPASS( 22, 0, 0, mseq, 0xffffffff, 5, 5 );
  TEST_RR_SRC12_BYPASS( 23, 0, 1, mseq, 0xffffffff, 7, 7 );
  TEST_RR_SRC12_BYPASS( 24, 0, 2, mseq, 0x00000000, 9, 10 );
  TEST_RR_SRC12_BYPASS( 25, 1, 0, mseq, 0xffffffff, 5, 5 );
  TEST_RR_SRC12_BYPASS( 26, 1, 1, mseq, 0xffffffff, 7, 7 );
  TEST_RR_SRC12_BYPASS( 27, 2, 0, mseq, 0x00000000, 9, 10 );

  TEST_RR_SRC21_BYPASS( 28, 0, 0, mseq, 0xffffffff, 5, 5 );
  TEST_RR_SRC21_BYPASS( 29, 0, 1, mseq, 0xffffffff, 7, 7 );
  TEST_RR_SRC21_BYPASS( 30, 0, 2, mseq, 0x00000000, 9, 10 );
  TEST_RR_SRC21_BYPASS( 31, 1, 0, mseq, 0xffffffff, 5, 5 );
  TEST_RR_SRC21_BYPASS( 32, 1, 1, mseq, 0xffffffff, 7, 7 );
  TEST_RR_SRC21_BYPASS( 33, 2, 0, mseq, 0x00000000, 9, 10 );

  TEST_RR_ZEROSRC1( 34, mseq, 0x00000000, 5 );
  TEST_RR_ZEROSRC2( 35, mseq, 0x00000000, 5 );
  TEST_RR_ZEROSRC12( 36, mseq, 0xffffffff );
  TEST_RR_ZERODEST( 37, mseq, 5, 5 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

