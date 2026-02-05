# See LICENSE for license details.

#*****************************************************************************
# padd_bs.S
#-----------------------------------------------------------------------------
#
# Test padd_bs instruction (packed add bytes with shift).
# Performs add on 4 x 8-bit elements with shift from rs2[7:0]: rd = rs1 + rs2[7:0]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add with shift value: rs1=0x04, rs2[7:0]=0x06, result=0x0A
  TEST_RR_OP( 2,  padd.bs, 0x0a0a0a0a, 0x04040404, 0x00000006 );
  
  # Different shift value: rs1=0x10, rs2[7:0]=0x20, result=0x30
  TEST_RR_OP( 3,  padd.bs, 0x30303030, 0x10101010, 0x00000020 );
  
  # Wrapping overflow: rs1=0xFF, rs2[7:0]=0x01, result=0x00
  TEST_RR_OP( 4,  padd.bs, 0x00000000, 0xffffffff, 0x00000001 );
  
  # Zero shift value: rs1=0x42, rs2[7:0]=0x00, result=0x42
  TEST_RR_OP( 5,  padd.bs, 0x42424242, 0x42424242, 0x00000000 );
  
  # Max shift value: rs1=0x01, rs2[7:0]=0xFF, result=0x00 (wraps)
  TEST_RR_OP( 6,  padd.bs, 0x00000000, 0x01010101, 0x000000ff );
  
  # Zero cases
  TEST_RR_OP( 7,  padd.bs, 0x00000000, 0x00000000, 0x00000000 );
  
  # Negative: rs1=0xFF, rs2[7:0]=0xFF, result=0xFE
  TEST_RR_OP( 8,  padd.bs, 0xfefefefe, 0xffffffff, 0x000000ff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, padd.bs, 0x0a0a0a0a, 0x04040404, 0x00000006 );
  TEST_RR_SRC2_EQ_DEST( 10, padd.bs, 0x0e0e0e0e, 0x06060606, 0x00000008 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

