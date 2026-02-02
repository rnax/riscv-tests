# See LICENSE for license details.

#*****************************************************************************
# asub.S
#-----------------------------------------------------------------------------
#
# Test asub instruction (signed averaging subtract).
# rd = (rs1 - rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging subtract: (10 - 4) >> 1 = 3
  TEST_RR_OP( 2,  asub, 0x00000003, 0x0000000a, 0x00000004 );
  # (20 - 10) >> 1 = 5
  TEST_RR_OP( 3,  asub, 0x00000005, 0x00000014, 0x0000000a );
  # Odd difference: (7 - 4) >> 1 = 1 (truncated)
  TEST_RR_OP( 4,  asub, 0x00000001, 0x00000007, 0x00000004 );
  
  # Negative numbers: (-4 - 6) >> 1 = -5
  TEST_RR_OP( 5,  asub, 0xfffffffb, 0xfffffffc, 0x00000006 );
  # (-10 - (-20)) >> 1 = 5
  TEST_RR_OP( 6,  asub, 0x00000005, 0xfffffff6, 0xffffffec );
  # (1 - (-1)) >> 1 = 1
  TEST_RR_OP( 7,  asub, 0x00000001, 0x00000001, 0xffffffff );
  
  # Large positive: (0x7FFFFFFF - 1) >> 1 = 0x3FFFFFFF
  TEST_RR_OP( 8,  asub, 0x3fffffff, 0x7fffffff, 0x00000001 );
  # Large negative: (0x80000000 - 0) >> 1 = 0xC0000000
  TEST_RR_OP( 9,  asub, 0xc0000000, 0x80000000, 0x00000000 );
  
  # Zero cases
  TEST_RR_OP( 10, asub, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 11, asub, 0x00000005, 0x0000000a, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 12, asub, 3, 10, 4 );
  TEST_RR_SRC2_EQ_DEST( 13, asub, 5, 14, 4 );
  TEST_RR_SRC12_EQ_DEST( 14, asub, 0, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 15, 0, asub, 3, 10, 4 );
  TEST_RR_DEST_BYPASS( 16, 1, asub, 5, 14, 4 );
  TEST_RR_DEST_BYPASS( 17, 2, asub, 7, 18, 4 );

  TEST_RR_SRC12_BYPASS( 18, 0, 0, asub, 3, 10, 4 );
  TEST_RR_SRC12_BYPASS( 19, 0, 1, asub, 5, 14, 4 );
  TEST_RR_SRC12_BYPASS( 20, 0, 2, asub, 7, 18, 4 );
  TEST_RR_SRC12_BYPASS( 21, 1, 0, asub, 3, 10, 4 );
  TEST_RR_SRC12_BYPASS( 22, 1, 1, asub, 5, 14, 4 );
  TEST_RR_SRC12_BYPASS( 23, 2, 0, asub, 7, 18, 4 );

  TEST_RR_SRC21_BYPASS( 24, 0, 0, asub, 3, 10, 4 );
  TEST_RR_SRC21_BYPASS( 25, 0, 1, asub, 5, 14, 4 );
  TEST_RR_SRC21_BYPASS( 26, 0, 2, asub, 7, 18, 4 );
  TEST_RR_SRC21_BYPASS( 27, 1, 0, asub, 3, 10, 4 );
  TEST_RR_SRC21_BYPASS( 28, 1, 1, asub, 5, 14, 4 );
  TEST_RR_SRC21_BYPASS( 29, 2, 0, asub, 7, 18, 4 );

  TEST_RR_ZEROSRC1( 30, asub, 0xfffffffd, 6 );
  TEST_RR_ZEROSRC2( 31, asub, 5, 10 );
  TEST_RR_ZEROSRC12( 32, asub, 0 );
  TEST_RR_ZERODEST( 33, asub, 10, 4 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

