# See LICENSE for license details.

#*****************************************************************************
# srari.S
#-----------------------------------------------------------------------------
#
# Test srari instruction (shift right arithmetic with rounding, immediate).
# rd = (rs1 >> shamtw) + ((rs1 >> (shamtw - 1)) & 1)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x00000005 >> 0 = 0x00000005
  TEST_RI_OP( 2,  srari, 0x00000005, 0x00000005, 0 );
  # Shift by 1: 0x00000005 >> 1 + round = 0x00000003
  TEST_RI_OP( 3,  srari, 0x00000003, 0x00000005, 1 );
  # Shift by 2: 0x00000005 >> 2 + round = 0x00000001
  TEST_RI_OP( 4,  srari, 0x00000001, 0x00000005, 2 );
  
  # Negative: 0xFFFFFFFF >> 1 + round = 0xFFFFFFFF
  TEST_RI_OP( 5,  srari, 0xffffffff, 0xffffffff, 1 );
  # Negative: 0xFFFFFFFE >> 1 + round = 0xFFFFFFFF
  TEST_RI_OP( 6,  srari, 0xffffffff, 0xfffffffe, 1 );
  # Negative: 0xFFFFFFFD >> 1 + round = 0xFFFFFFFE
  TEST_RI_OP( 7,  srari, 0xfffffffe, 0xfffffffd, 1 );
  
  # Shift by 8: 0x00000100 >> 8 + round = 0x00000001
  TEST_RI_OP( 8,  srari, 0x00000001, 0x00000100, 8 );
  # Shift by 16: 0x00010000 >> 16 + round = 0x00000001
  TEST_RI_OP( 9,  srari, 0x00000001, 0x00010000, 16 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RI_SRC1_EQ_DEST( 10, srari, 0x00000003, 0x00000005, 1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RI_DEST_BYPASS( 11, 0, srari, 0x00000003, 0x00000005, 1 );
  TEST_RI_DEST_BYPASS( 12, 1, srari, 0x00000001, 0x00000005, 2 );
  TEST_RI_DEST_BYPASS( 13, 2, srari, 0xffffffff, 0xffffffff, 1 );

  TEST_RI_SRC1_BYPASS( 14, 0, srari, 0x00000003, 0x00000005, 1 );
  TEST_RI_SRC1_BYPASS( 15, 1, srari, 0x00000001, 0x00000005, 2 );
  TEST_RI_SRC1_BYPASS( 16, 2, srari, 0xffffffff, 0xffffffff, 1 );

  TEST_RI_ZEROSRC1( 17, srari, 0x00000000, 1 );
  TEST_RI_ZERODEST( 18, srari, 0x00000005, 1 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

