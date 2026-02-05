# See LICENSE for license details.

#*****************************************************************************
# pmul_h_b11.S
#-----------------------------------------------------------------------------
#
# Test pmul.h.b11 instruction (packed multiply halfword top-top).
# rd[31:16] = sext(rs1[31:16]) * sext(rs2[31:16])
# rd[15:0] = sext(rs1[31:16]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x0015)
  TEST_RR_OP( 2,  pmul.h.b11, 0x00150015, 0x00030000, 0x00070000 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x1388)
  TEST_RR_OP( 3,  pmul.h.b11, 0x13881388, 0x00640000, 0x00320000 );
  
  # Negative multiply: (-10) * 20 = -200 (0xff38)
  TEST_RR_OP( 4,  pmul.h.b11, 0xff38ff38, 0xfff60000, 0x00140000 );
  
  # Halfword selection (top 16 bits): 0x1234 * 0x5678 = 0x5b3a4c
  TEST_RR_OP( 5,  pmul.h.b11, 0x5b3a5b3a, 0x12340000, 0x56780000 );
  
  # Negative result: (-5) * 10 = -50 (0xffce)
  TEST_RR_OP( 6,  pmul.h.b11, 0xffceffce, 0xfffb0000, 0x000a0000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmul.h.b11, 0x00000000, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmul.h.b11, 0x00150015, 0x00030000, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, pmul.h.b11, 0x00230023, 0x00050000, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

