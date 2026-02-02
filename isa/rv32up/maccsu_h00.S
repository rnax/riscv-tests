# See LICENSE for license details.

#*****************************************************************************
# maccsu_h00.S
#-----------------------------------------------------------------------------
#
# Test maccsu.h00 instruction (multiply-accumulate signed*unsigned halfword 00).
# rd = rd + sext(rs1[15:0]) * zext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_RR_OP( 2,  maccsu.h00, 0x00000015, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_RR_OP( 3,  maccsu.h00, 0x00000096, 0x00000064, 0x00000005, 0x0000000a );
  
  # Signed negative * unsigned: 1000 + (-10) * 20 = 800
  TEST_RR_OP( 4,  maccsu.h00, 0x00000320, 0x000003e8, 0xfffffff6, 0x00000014 );
  
  # Halfword selection (lower 16 bits): 0 + 0x0005 * 0x000a = 50
  TEST_RR_OP( 5,  maccsu.h00, 0x00000032, 0x00000000, 0x12340005, 0x5678000a );
  
  # Negative signed * unsigned: -100 + (-5) * 10 = -150
  TEST_RR_OP( 6,  maccsu.h00, 0xffffff6a, 0xffffff9c, 0xfffffffb, 0x0000000a );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_RR_OP( 7,  maccsu.h00, 0x000001f4, 0x000001f4, 0x00000000, 0x00000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, maccsu.h00, 21, 0, 3, 7 );
  TEST_RR_SRC2_EQ_DEST( 9, maccsu.h00, 35, 5, 5, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

