# See LICENSE for license details.

#*****************************************************************************
# sslai.S
#-----------------------------------------------------------------------------
#
# Test sslai instruction (saturating shift left arithmetic, immediate).
# rd = SAT(rs1 << shamtw)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Left shift by 0: 0x00000005 << 0 = 0x00000005
  TEST_RI_OP( 2,  sslai, 0x00000005, 0x00000005, 0 );
  # Left shift by 1: 0x00000005 << 1 = 0x0000000A
  TEST_RI_OP( 3,  sslai, 0x0000000a, 0x00000005, 1 );
  # Left shift by 2: 0x00000005 << 2 = 0x00000014
  TEST_RI_OP( 4,  sslai, 0x00000014, 0x00000005, 2 );
  
  # Saturation: 0x40000000 << 1 saturates to 0x7FFFFFFF
  TEST_RI_OP( 5,  sslai, 0x7fffffff, 0x40000000, 1 );
  # Saturation: 0xC0000000 << 1 saturates to 0x80000000
  TEST_RI_OP( 6,  sslai, 0x80000000, 0xc0000000, 1 );
  
  # Saturation: 0x00000100 << 8 saturates to 0x7FFFFFFF
  TEST_RI_OP( 7,  sslai, 0x7fffffff, 0x00000100, 8 );
  # Saturation: 0xFFFFFF00 << 8 saturates to 0x80000000
  TEST_RI_OP( 8,  sslai, 0x80000000, 0xffffff00, 8 );
  
  # Zero input
  TEST_RI_OP( 9,  sslai, 0x00000000, 0x00000000, 1 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RI_SRC1_EQ_DEST( 10, sslai, 0x0000000a, 0x00000005, 1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RI_DEST_BYPASS( 11, 0, sslai, 0x0000000a, 0x00000005, 1 );
  TEST_RI_DEST_BYPASS( 12, 1, sslai, 0x00000014, 0x00000005, 2 );
  TEST_RI_DEST_BYPASS( 13, 2, sslai, 0x7fffffff, 0x40000000, 1 );

  TEST_RI_SRC1_BYPASS( 14, 0, sslai, 0x0000000a, 0x00000005, 1 );
  TEST_RI_SRC1_BYPASS( 15, 1, sslai, 0x00000014, 0x00000005, 2 );
  TEST_RI_SRC1_BYPASS( 16, 2, sslai, 0x7fffffff, 0x40000000, 1 );

  TEST_RI_ZEROSRC1( 17, sslai, 0x00000000, 1 );
  TEST_RI_ZERODEST( 18, sslai, 0x00000005, 1 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

