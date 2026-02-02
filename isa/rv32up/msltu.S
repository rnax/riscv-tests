# See LICENSE for license details.

#*****************************************************************************
# msltu.S
#-----------------------------------------------------------------------------
#
# Test msltu instruction (mask unsigned less than).
# rd = ((uint32_t)rs1 < (uint32_t)rs2) ? -1 : 0
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Less than cases (result = 0xFFFFFFFF)
  TEST_RR_OP( 2,  msltu, 0xffffffff, 0x00000000, 0x00000001 );
  TEST_RR_OP( 3,  msltu, 0xffffffff, 0x00000001, 0x00000002 );
  TEST_RR_OP( 4,  msltu, 0xffffffff, 0x0000000a, 0x00000014 );
  
  # Not less than cases (result = 0x00000000)
  TEST_RR_OP( 5,  msltu, 0x00000000, 0x00000001, 0x00000000 );
  TEST_RR_OP( 6,  msltu, 0x00000000, 0x00000002, 0x00000001 );
  TEST_RR_OP( 7,  msltu, 0x00000000, 0x00000014, 0x0000000a );
  
  # Equal cases (result = 0x00000000)
  TEST_RR_OP( 8,  msltu, 0x00000000, 0x00000005, 0x00000005 );
  TEST_RR_OP( 9,  msltu, 0x00000000, 0xffffffff, 0xffffffff );
  
  # Unsigned: negative values treated as large positive
  TEST_RR_OP( 10, msltu, 0xffffffff, 0x00000001, 0xffffffff );
  TEST_RR_OP( 11, msltu, 0x00000000, 0xffffffff, 0x00000001 );
  
  # Unsigned: both negative (large positive)
  TEST_RR_OP( 12, msltu, 0xffffffff, 0xfffffffc, 0xfffffffd );
  TEST_RR_OP( 13, msltu, 0x00000000, 0xfffffffd, 0xfffffffc );
  
  # Boundary values
  TEST_RR_OP( 14, msltu, 0xffffffff, 0x00000000, 0x80000000 );
  TEST_RR_OP( 15, msltu, 0x00000000, 0x80000000, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 16, msltu, 0x00000000, 5, 5 );
  TEST_RR_SRC2_EQ_DEST( 17, msltu, 0x00000000, 7, 7 );
  TEST_RR_SRC12_EQ_DEST( 18, msltu, 0x00000000, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 19, 0, msltu, 0xffffffff, 5, 10 );
  TEST_RR_DEST_BYPASS( 20, 1, msltu, 0x00000000, 10, 5 );
  TEST_RR_DEST_BYPASS( 21, 2, msltu, 0x00000000, 9, 9 );

  TEST_RR_SRC12_BYPASS( 22, 0, 0, msltu, 0xffffffff, 5, 10 );
  TEST_RR_SRC12_BYPASS( 23, 0, 1, msltu, 0x00000000, 10, 5 );
  TEST_RR_SRC12_BYPASS( 24, 0, 2, msltu, 0x00000000, 9, 9 );
  TEST_RR_SRC12_BYPASS( 25, 1, 0, msltu, 0xffffffff, 5, 10 );
  TEST_RR_SRC12_BYPASS( 26, 1, 1, msltu, 0x00000000, 10, 5 );
  TEST_RR_SRC12_BYPASS( 27, 2, 0, msltu, 0x00000000, 9, 9 );

  TEST_RR_SRC21_BYPASS( 28, 0, 0, msltu, 0xffffffff, 5, 10 );
  TEST_RR_SRC21_BYPASS( 29, 0, 1, msltu, 0x00000000, 10, 5 );
  TEST_RR_SRC21_BYPASS( 30, 0, 2, msltu, 0x00000000, 9, 9 );
  TEST_RR_SRC21_BYPASS( 31, 1, 0, msltu, 0xffffffff, 5, 10 );
  TEST_RR_SRC21_BYPASS( 32, 1, 1, msltu, 0x00000000, 10, 5 );
  TEST_RR_SRC21_BYPASS( 33, 2, 0, msltu, 0x00000000, 9, 9 );

  TEST_RR_ZEROSRC1( 34, msltu, 0xffffffff, 5 );
  TEST_RR_ZEROSRC2( 35, msltu, 0x00000000, 5 );
  TEST_RR_ZEROSRC12( 36, msltu, 0x00000000 );
  TEST_RR_ZERODEST( 37, msltu, 5, 10 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

