# See LICENSE for license details.

#*****************************************************************************
# sati.S
#-----------------------------------------------------------------------------
#
# Test sati instruction (signed saturation with immediate).
# rd = SAT(rs1, shamtw + 1) [signed]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturation to 1-bit: 0x00000001 -> 0x00000000 (fits in 1 bit)
  TEST_RI_OP( 2,  sati, 0x00000000, 0x00000001, 0 );
  # Saturation to 1-bit: 0x00000002 -> 0x00000001 (saturates)
  TEST_RI_OP( 3,  sati, 0x00000001, 0x00000002, 0 );
  
  # Saturation to 8-bit: 0x0000007F -> 0x0000007F (fits)
  TEST_RI_OP( 4,  sati, 0x0000007f, 0x0000007f, 6 );
  # Saturation to 8-bit: 0x00000080 -> 0x0000007F (saturates)
  TEST_RI_OP( 5,  sati, 0x0000007f, 0x00000080, 6 );
  
  # Saturation to 16-bit: 0x00007FFF -> 0x00007FFF (fits)
  TEST_RI_OP( 6,  sati, 0x00007fff, 0x00007fff, 14 );
  # Saturation to 16-bit: 0x00008000 -> 0x00007FFF (saturates)
  TEST_RI_OP( 7,  sati, 0x00007fff, 0x00008000, 14 );
  
  # Negative: -1 fits in any bit width
  TEST_RI_OP( 8,  sati, 0xffffffff, 0xffffffff, 6 );
  # Negative saturation: 0xFFFFFF80 -> 0xFFFFFF80 (fits in 8-bit signed)
  TEST_RI_OP( 9,  sati, 0xffffff80, 0xffffff80, 6 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RI_SRC1_EQ_DEST( 10, sati, 0x0000007f, 0x00000080, 6 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RI_DEST_BYPASS( 11, 0, sati, 0x0000007f, 0x00000080, 6 );
  TEST_RI_DEST_BYPASS( 12, 1, sati, 0x00007fff, 0x00008000, 14 );
  TEST_RI_DEST_BYPASS( 13, 2, sati, 0x00000001, 0x00000002, 0 );

  TEST_RI_SRC1_BYPASS( 14, 0, sati, 0x0000007f, 0x00000080, 6 );
  TEST_RI_SRC1_BYPASS( 15, 1, sati, 0x00007fff, 0x00008000, 14 );
  TEST_RI_SRC1_BYPASS( 16, 2, sati, 0x00000001, 0x00000002, 0 );

  TEST_RI_ZEROSRC1( 17, sati, 0x00000000, 6 );
  TEST_RI_ZERODEST( 18, sati, 0x00000080, 6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

