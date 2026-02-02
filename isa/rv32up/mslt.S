# See LICENSE for license details.

#*****************************************************************************
# mslt.S
#-----------------------------------------------------------------------------
#
# Test mslt instruction (mask signed less than).
# rd = ((int32_t)rs1 < (int32_t)rs2) ? -1 : 0
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Less than cases (result = 0xFFFFFFFF)
  TEST_RR_OP( 2,  mslt, 0xffffffff, 0x00000000, 0x00000001 );
  TEST_RR_OP( 3,  mslt, 0xffffffff, 0x00000001, 0x00000002 );
  TEST_RR_OP( 4,  mslt, 0xffffffff, 0x0000000a, 0x00000014 );
  
  # Not less than cases (result = 0x00000000)
  TEST_RR_OP( 5,  mslt, 0x00000000, 0x00000001, 0x00000000 );
  TEST_RR_OP( 6,  mslt, 0x00000000, 0x00000002, 0x00000001 );
  TEST_RR_OP( 7,  mslt, 0x00000000, 0x00000014, 0x0000000a );
  
  # Equal cases (result = 0x00000000)
  TEST_RR_OP( 8,  mslt, 0x00000000, 0x00000005, 0x00000005 );
  TEST_RR_OP( 9,  mslt, 0x00000000, 0xffffffff, 0xffffffff );
  
  # Negative less than positive
  TEST_RR_OP( 10, mslt, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 11, mslt, 0xffffffff, 0xfffffffc, 0x00000000 );
  
  # Negative less than negative
  TEST_RR_OP( 12, mslt, 0xffffffff, 0xfffffffc, 0xfffffffd );
  TEST_RR_OP( 13, mslt, 0x00000000, 0xfffffffd, 0xfffffffc );
  
  # Boundary values
  TEST_RR_OP( 14, mslt, 0xffffffff, 0x80000000, 0x7fffffff );
  TEST_RR_OP( 15, mslt, 0x00000000, 0x7fffffff, 0x80000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 16, mslt, 0x00000000, 5, 5 );
  TEST_RR_SRC2_EQ_DEST( 17, mslt, 0x00000000, 7, 7 );
  TEST_RR_SRC12_EQ_DEST( 18, mslt, 0x00000000, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 19, 0, mslt, 0xffffffff, 5, 10 );
  TEST_RR_DEST_BYPASS( 20, 1, mslt, 0x00000000, 10, 5 );
  TEST_RR_DEST_BYPASS( 21, 2, mslt, 0x00000000, 9, 9 );

  TEST_RR_SRC12_BYPASS( 22, 0, 0, mslt, 0xffffffff, 5, 10 );
  TEST_RR_SRC12_BYPASS( 23, 0, 1, mslt, 0x00000000, 10, 5 );
  TEST_RR_SRC12_BYPASS( 24, 0, 2, mslt, 0x00000000, 9, 9 );
  TEST_RR_SRC12_BYPASS( 25, 1, 0, mslt, 0xffffffff, 5, 10 );
  TEST_RR_SRC12_BYPASS( 26, 1, 1, mslt, 0x00000000, 10, 5 );
  TEST_RR_SRC12_BYPASS( 27, 2, 0, mslt, 0x00000000, 9, 9 );

  TEST_RR_SRC21_BYPASS( 28, 0, 0, mslt, 0xffffffff, 5, 10 );
  TEST_RR_SRC21_BYPASS( 29, 0, 1, mslt, 0x00000000, 10, 5 );
  TEST_RR_SRC21_BYPASS( 30, 0, 2, mslt, 0x00000000, 9, 9 );
  TEST_RR_SRC21_BYPASS( 31, 1, 0, mslt, 0xffffffff, 5, 10 );
  TEST_RR_SRC21_BYPASS( 32, 1, 1, mslt, 0x00000000, 10, 5 );
  TEST_RR_SRC21_BYPASS( 33, 2, 0, mslt, 0x00000000, 9, 9 );

  TEST_RR_ZEROSRC1( 34, mslt, 0xffffffff, 5 );
  TEST_RR_ZEROSRC2( 35, mslt, 0x00000000, 5 );
  TEST_RR_ZEROSRC12( 36, mslt, 0x00000000 );
  TEST_RR_ZERODEST( 37, mslt, 5, 10 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

