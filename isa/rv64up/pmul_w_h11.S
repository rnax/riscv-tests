# See LICENSE for license details.

#*****************************************************************************
# pmul.w.h11.S
#-----------------------------------------------------------------------------
#
# Test pmul.w.h11 instruction (packed multiply word halfword top-top).
# rd[63:32] = sext(rs1[31:16]) * sext(rs2[31:16])
# rd[31:0] = sext(rs1[31:16]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x00000015)
  TEST_RR_OP( 2,  pmul.w.h11, 0x0000001500000015, 0x0003000300030003, 0x0007000700070007 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x00001388)
  TEST_RR_OP( 3,  pmul.w.h11, 0x0000138800001388, 0x0064006400640064, 0x0032003200320032 );
  
  # Negative multiply: (-10) * 20 = -200 (0xffffff38)
  TEST_RR_OP( 4,  pmul.w.h11, 0xffffff38ffffff38, 0xfff6fff6fff6fff6, 0x0014001400140014 );
  
  # Halfword selection (top-top): 0x1234 * 0x5678 = 0x5b3a4c0
  TEST_RR_OP( 5,  pmul.w.h11, 0x05b3a4c005b3a4c0, 0x1234123412341234, 0x5678567856785678 );
  
  # Negative result: (-5) * 10 = -50 (0xffffffce)
  TEST_RR_OP( 6,  pmul.w.h11, 0xffffffceffffffce, 0xfffbfffbfffbfffb, 0x000a000a000a000a );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmul.w.h11, 0x0000000000000000, 0x0000000000000000, 0x0064006400640064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmul.w.h11, 0x0000001500000015, 0x0003000300030003, 0x0007000700070007 );
  TEST_RR_SRC2_EQ_DEST( 9, pmul.w.h11, 0x0000002300000023, 0x0005000500050005, 0x0007000700070007 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

