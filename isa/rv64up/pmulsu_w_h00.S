# See LICENSE for license details.

#*****************************************************************************
# pmulsu_w_h00.S
#-----------------------------------------------------------------------------
#
# Test pmulsu.w.h00 instruction (packed multiply signed*unsigned word bottom-bottom).
# rd[63:32] = sext(rs1[15:0]) * zext(rs2[15:0])
# rd[31:0] = sext(rs1[15:0]) * zext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x00000015)
  TEST_RR_OP( 2,  pmulsu.w.h00, 0x0000001500000015, 0x0000000300000003, 0x0000000700000007 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x00001388)
  TEST_RR_OP( 3,  pmulsu.w.h00, 0x0000138800001388, 0x0000006400000064, 0x0000003200000032 );
  
  # Signed * Unsigned: (-10) * 20 = -200 (0xffffff38)
  TEST_RR_OP( 4,  pmulsu.w.h00, 0xffffff38ffffff38, 0xfffffff6fffffff6, 0x0000001400000014 );
  
  # Halfword selection (lower 16 bits): 0x0005 * 0x000a = 50 (0x00000032)
  TEST_RR_OP( 5,  pmulsu.w.h00, 0x0000003200000032, 0x1234000512340005, 0x5678000a5678000a );
  
  # Negative signed: (-5) * 10 = -50 (0xffffffce)
  TEST_RR_OP( 6,  pmulsu.w.h00, 0xffffffceffffffce, 0xfffffffbfffffffb, 0x000000000000000a );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulsu.w.h00, 0x0000000000000000, 0x0000000000000000, 0x0000006400000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulsu.w.h00, 0x0000001500000015, 0x0000000300000003, 0x0000000700000007 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulsu.w.h00, 0x0000002300000023, 0x0000000500000005, 0x0000000700000007 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

