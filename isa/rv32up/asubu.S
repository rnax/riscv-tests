# See LICENSE for license details.

#*****************************************************************************
# asubu.S
#-----------------------------------------------------------------------------
#
# Test asubu instruction (unsigned averaging subtract).
# rd = ((uint64_t)rs1 - (uint64_t)rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned averaging subtract: (10 - 4) >> 1 = 3
  TEST_RR_OP( 2,  asubu, 0x00000003, 0x0000000a, 0x00000004 );
  # (20 - 10) >> 1 = 5
  TEST_RR_OP( 3,  asubu, 0x00000005, 0x00000014, 0x0000000a );
  # Odd difference: (7 - 4) >> 1 = 1 (truncated)
  TEST_RR_OP( 4,  asubu, 0x00000001, 0x00000007, 0x00000004 );
  
  # Large unsigned: (0xFFFFFFFF - 1) >> 1 = 0x7FFFFFFF
  TEST_RR_OP( 5,  asubu, 0x7fffffff, 0xffffffff, 0x00000001 );
  # (0xFFFFFFFF - 0xFFFFFFFF) >> 1 = 0
  TEST_RR_OP( 6,  asubu, 0x00000000, 0xffffffff, 0xffffffff );
  # (0x80000000 - 0x80000000) >> 1 = 0
  TEST_RR_OP( 7,  asubu, 0x00000000, 0x80000000, 0x80000000 );
  
  # Zero cases
  TEST_RR_OP( 8,  asubu, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 9,  asubu, 0x00000005, 0x0000000a, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, asubu, 3, 10, 4 );
  TEST_RR_SRC2_EQ_DEST( 11, asubu, 5, 14, 4 );
  TEST_RR_SRC12_EQ_DEST( 12, asubu, 0, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, asubu, 3, 10, 4 );
  TEST_RR_DEST_BYPASS( 14, 1, asubu, 5, 14, 4 );
  TEST_RR_DEST_BYPASS( 15, 2, asubu, 7, 18, 4 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, asubu, 3, 10, 4 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, asubu, 5, 14, 4 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, asubu, 7, 18, 4 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, asubu, 3, 10, 4 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, asubu, 5, 14, 4 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, asubu, 7, 18, 4 );

  TEST_RR_SRC21_BYPASS( 22, 0, 0, asubu, 3, 10, 4 );
  TEST_RR_SRC21_BYPASS( 23, 0, 1, asubu, 5, 14, 4 );
  TEST_RR_SRC21_BYPASS( 24, 0, 2, asubu, 7, 18, 4 );
  TEST_RR_SRC21_BYPASS( 25, 1, 0, asubu, 3, 10, 4 );
  TEST_RR_SRC21_BYPASS( 26, 1, 1, asubu, 5, 14, 4 );
  TEST_RR_SRC21_BYPASS( 27, 2, 0, asubu, 7, 18, 4 );

  TEST_RR_ZEROSRC1( 28, asubu, 0xfffffffd, 6 );
  TEST_RR_ZEROSRC2( 29, asubu, 5, 10 );
  TEST_RR_ZEROSRC12( 30, asubu, 0 );
  TEST_RR_ZERODEST( 31, asubu, 10, 4 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

