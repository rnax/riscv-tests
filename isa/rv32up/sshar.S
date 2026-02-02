# See LICENSE for license details.

#*****************************************************************************
# sshar.S
#-----------------------------------------------------------------------------
#
# Test sshar instruction (saturating shift left arithmetic with rounding).
# rd = SAT(rs1 << shamt) or ((rs1 >> -shamt) + round) if shamt < 0
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Left shift: 0x00000001 << 1 = 0x00000002
  TEST_RR_OP( 2,  sshar, 0x00000002, 0x00000001, 0x00000001 );
  # Left shift: 0x00000005 << 2 = 0x00000014
  TEST_RR_OP( 3,  sshar, 0x00000014, 0x00000005, 0x00000002 );
  
  # Saturation on left shift: 0x40000000 << 1 saturates to 0x7FFFFFFF
  TEST_RR_OP( 4,  sshar, 0x7fffffff, 0x40000000, 0x00000001 );
  # Saturation on left shift: 0xC0000000 << 1 saturates to 0x80000000
  TEST_RR_OP( 5,  sshar, 0x80000000, 0xc0000000, 0x00000001 );
  
  # Right shift with rounding: 0x00000005 >> 1 + round = 0x00000003
  TEST_RR_OP( 6,  sshar, 0x00000003, 0x00000005, 0xffffffff );
  # Right shift with rounding: 0x00000014 >> 2 + round = 0x00000005
  TEST_RR_OP( 7,  sshar, 0x00000005, 0x00000014, 0xfffffffe );
  
  # Zero input
  TEST_RR_OP( 8,  sshar, 0x00000000, 0x00000000, 0x00000001 );
  # Zero shift amount
  TEST_RR_OP( 9,  sshar, 0x00000005, 0x00000005, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, sshar, 2, 1, 1 );
  TEST_RR_SRC2_EQ_DEST( 11, sshar, 2, 1, 1 );
  TEST_RR_SRC12_EQ_DEST( 12, sshar, 2, 1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, sshar, 2, 1, 1 );
  TEST_RR_DEST_BYPASS( 14, 1, sshar, 4, 1, 2 );
  TEST_RR_DEST_BYPASS( 15, 2, sshar, 8, 1, 3 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, sshar, 2, 1, 1 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, sshar, 4, 1, 2 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, sshar, 8, 1, 3 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, sshar, 2, 1, 1 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, sshar, 4, 1, 2 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, sshar, 8, 1, 3 );

  TEST_RR_ZEROSRC1( 22, sshar, 0, 1 );
  TEST_RR_ZEROSRC2( 23, sshar, 5, 0 );
  TEST_RR_ZEROSRC12( 24, sshar, 0 );
  TEST_RR_ZERODEST( 25, sshar, 1, 1 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

