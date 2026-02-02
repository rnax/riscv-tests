# See LICENSE for license details.

#*****************************************************************************
# usati.S
#-----------------------------------------------------------------------------
#
# Test usati instruction (unsigned saturation with immediate).
# rd = SAT(rs1, shamtw + 1) [unsigned]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturation to 1-bit: 0x00000000 -> 0x00000000 (fits)
  TEST_RI_OP( 2,  usati, 0x00000000, 0x00000000, 0 );
  # Saturation to 1-bit: 0x00000001 -> 0x00000001 (fits)
  TEST_RI_OP( 3,  usati, 0x00000001, 0x00000001, 0 );
  # Saturation to 1-bit: 0x00000002 -> 0x00000001 (saturates)
  TEST_RI_OP( 4,  usati, 0x00000001, 0x00000002, 0 );
  
  # Saturation to 8-bit: 0x000000FF -> 0x000000FF (fits)
  TEST_RI_OP( 5,  usati, 0x000000ff, 0x000000ff, 7 );
  # Saturation to 8-bit: 0x00000100 -> 0x000000FF (saturates)
  TEST_RI_OP( 6,  usati, 0x000000ff, 0x00000100, 7 );
  
  # Saturation to 16-bit: 0x0000FFFF -> 0x0000FFFF (fits)
  TEST_RI_OP( 7,  usati, 0x0000ffff, 0x0000ffff, 15 );
  # Saturation to 16-bit: 0x00010000 -> 0x0000FFFF (saturates)
  TEST_RI_OP( 8,  usati, 0x0000ffff, 0x00010000, 15 );
  
  # Large values saturate
  TEST_RI_OP( 9,  usati, 0x000000ff, 0xffffffff, 7 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RI_SRC1_EQ_DEST( 10, usati, 0x000000ff, 0x00000100, 7 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RI_DEST_BYPASS( 11, 0, usati, 0x000000ff, 0x00000100, 7 );
  TEST_RI_DEST_BYPASS( 12, 1, usati, 0x0000ffff, 0x00010000, 15 );
  TEST_RI_DEST_BYPASS( 13, 2, usati, 0x00000001, 0x00000002, 0 );

  TEST_RI_SRC1_BYPASS( 14, 0, usati, 0x000000ff, 0x00000100, 7 );
  TEST_RI_SRC1_BYPASS( 15, 1, usati, 0x0000ffff, 0x00010000, 15 );
  TEST_RI_SRC1_BYPASS( 16, 2, usati, 0x00000001, 0x00000002, 0 );

  TEST_RI_ZEROSRC1( 17, usati, 0x00000000, 7 );
  TEST_RI_ZERODEST( 18, usati, 0x00000100, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

