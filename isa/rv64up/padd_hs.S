# See LICENSE for license details.

#*****************************************************************************
# padd_hs.S
#-----------------------------------------------------------------------------
#
# Test padd_hs instruction (packed add halfwords with shift).
# Performs add on 2 x 16-bit elements with shift from rs2[15:0]: rd = rs1 + rs2[15:0]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add with shift value: rs1=0x0004, rs2[15:0]=0x0006, result=0x000A
  TEST_RR_OP( 2,  padd.hs, 0x000a000a, 0x00040004, 0x00000006 );
  
  # Different shift value: rs1=0x1000, rs2[15:0]=0x2000, result=0x3000
  TEST_RR_OP( 3,  padd.hs, 0x30003000, 0x10001000, 0x00002000 );
  
  # Wrapping overflow: rs1=0xFFFF, rs2[15:0]=0x0001, result=0x0000
  TEST_RR_OP( 4,  padd.hs, 0x00000000, 0xffffffff, 0x00000001 );
  
  # Zero shift value: rs1=0x4242, rs2[15:0]=0x0000, result=0x4242
  TEST_RR_OP( 5,  padd.hs, 0x42424242, 0x42424242, 0x00000000 );
  
  # Max shift value: rs1=0x0001, rs2[15:0]=0xFFFF, result=0x0000 (wraps)
  TEST_RR_OP( 6,  padd.hs, 0x00000000, 0x00010001, 0x0000ffff );
  
  # Zero cases
  TEST_RR_OP( 7,  padd.hs, 0x00000000, 0x00000000, 0x00000000 );
  
  # Negative: rs1=0xFFFF, rs2[15:0]=0xFFFF, result=0xFFFE
  TEST_RR_OP( 8,  padd.hs, 0xfffffffe, 0xffffffff, 0x0000ffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, padd.hs, 0x000a000a, 0x00040004, 0x00000006 );
  TEST_RR_SRC2_EQ_DEST( 10, padd.hs, 0x000e000e, 0x00060006, 0x00000008 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

