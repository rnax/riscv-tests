# See LICENSE for license details.

#*****************************************************************************
# pmul_h_b01.S
#-----------------------------------------------------------------------------
#
# Test pmul.h.b01 instruction (packed multiply halfword bottom-top).
# rd[31:16] = sext(rs1[15:0]) * sext(rs2[31:16])
# rd[15:0] = sext(rs1[15:0]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x0015)
  TEST_RR_OP( 2,  pmul.h.b01, 0x00150015, 0x00000003, 0x00070000 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x1388)
  TEST_RR_OP( 3,  pmul.h.b01, 0x13881388, 0x00000064, 0x00320000 );
  
  # Negative multiply: (-10) * 20 = -200 (0xff38)
  TEST_RR_OP( 4,  pmul.h.b01, 0xff38ff38, 0xfffffff6, 0x00140000 );
  
  # Halfword selection (top 16 bits of rs2): 0x0005 * 0x5678 = 0x1b3e0
  TEST_RR_OP( 5,  pmul.h.b01, 0x1b3e1b3e, 0x12340005, 0x5678000a );
  
  # Negative result: (-5) * 10 = -50 (0xffce)
  TEST_RR_OP( 6,  pmul.h.b01, 0xffceffce, 0xfffffffb, 0x000a0000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmul.h.b01, 0x00000000, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmul.h.b01, 0x00150015, 3, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, pmul.h.b01, 0x00230023, 5, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

