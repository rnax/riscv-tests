# See LICENSE for license details.

#*****************************************************************************
# aadd.S
#-----------------------------------------------------------------------------
#
# Test aadd instruction (signed averaging add).
# rd = (rs1 + rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (4 + 6) >> 1 = 5
  TEST_RR_OP( 2,  aadd, 0x00000005, 0x00000004, 0x00000006 );
  # (10 + 20) >> 1 = 15
  TEST_RR_OP( 3,  aadd, 0x0000000f, 0x0000000a, 0x00000014 );
  # Odd sum: (3 + 4) >> 1 = 3 (truncated)
  TEST_RR_OP( 4,  aadd, 0x00000003, 0x00000003, 0x00000004 );
  
  # Negative numbers: (-4 + 6) >> 1 = 1
  TEST_RR_OP( 5,  aadd, 0x00000001, 0xfffffffc, 0x00000006 );
  # (-10 + -20) >> 1 = -15
  TEST_RR_OP( 6,  aadd, 0xfffffff1, 0xfffffff6, 0xffffffec );
  # (-1 + 1) >> 1 = 0
  TEST_RR_OP( 7,  aadd, 0x00000000, 0xffffffff, 0x00000001 );
  
  # Large positive: (0x7FFFFFFF + 1) >> 1 = 0x40000000
  TEST_RR_OP( 8,  aadd, 0x40000000, 0x7fffffff, 0x00000001 );
  # Large negative: (0x80000000 + 0) >> 1 = 0xC0000000
  TEST_RR_OP( 9,  aadd, 0xc0000000, 0x80000000, 0x00000000 );
  
  # Zero cases
  TEST_RR_OP( 10, aadd, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 11, aadd, 0x00000005, 0x0000000a, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 12, aadd, 5, 4, 6 );
  TEST_RR_SRC2_EQ_DEST( 13, aadd, 7, 6, 8 );
  TEST_RR_SRC12_EQ_DEST( 14, aadd, 10, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 15, 0, aadd, 5, 4, 6 );
  TEST_RR_DEST_BYPASS( 16, 1, aadd, 7, 6, 8 );
  TEST_RR_DEST_BYPASS( 17, 2, aadd, 9, 8, 10 );

  TEST_RR_SRC12_BYPASS( 18, 0, 0, aadd, 5, 4, 6 );
  TEST_RR_SRC12_BYPASS( 19, 0, 1, aadd, 7, 6, 8 );
  TEST_RR_SRC12_BYPASS( 20, 0, 2, aadd, 9, 8, 10 );
  TEST_RR_SRC12_BYPASS( 21, 1, 0, aadd, 5, 4, 6 );
  TEST_RR_SRC12_BYPASS( 22, 1, 1, aadd, 7, 6, 8 );
  TEST_RR_SRC12_BYPASS( 23, 2, 0, aadd, 9, 8, 10 );

  TEST_RR_SRC21_BYPASS( 24, 0, 0, aadd, 5, 4, 6 );
  TEST_RR_SRC21_BYPASS( 25, 0, 1, aadd, 7, 6, 8 );
  TEST_RR_SRC21_BYPASS( 26, 0, 2, aadd, 9, 8, 10 );
  TEST_RR_SRC21_BYPASS( 27, 1, 0, aadd, 5, 4, 6 );
  TEST_RR_SRC21_BYPASS( 28, 1, 1, aadd, 7, 6, 8 );
  TEST_RR_SRC21_BYPASS( 29, 2, 0, aadd, 9, 8, 10 );

  TEST_RR_ZEROSRC1( 30, aadd, 3, 6 );
  TEST_RR_ZEROSRC2( 31, aadd, 5, 10 );
  TEST_RR_ZEROSRC12( 32, aadd, 0 );
  TEST_RR_ZERODEST( 33, aadd, 4, 6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

