# See LICENSE for license details.

#*****************************************************************************
# macc_h01.S
#-----------------------------------------------------------------------------
#
# Test macc.h01 instruction (multiply-accumulate halfword 01).
# rd = rd + sext(rs1[15:0]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_RR_OP( 2,  macc.h01, 0x00000015, 0x00000000, 0x00000003, 0x00070000 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_RR_OP( 3,  macc.h01, 0x00000096, 0x00000064, 0x00000005, 0x000a0000 );
  
  # Negative accumulation: 1000 + (-10) * 20 = 800
  TEST_RR_OP( 4,  macc.h01, 0x00000320, 0x000003e8, 0xfffffff6, 0x00140000 );
  
  # Halfword selection (lower 16 bits of rs1, upper 16 bits of rs2): 0 + 0x0005 * 0x000a = 50
  TEST_RR_OP( 5,  macc.h01, 0x00000032, 0x00000000, 0x12340005, 0x000a5678 );
  
  # Negative result: -100 + (-5) * 10 = -150
  TEST_RR_OP( 6,  macc.h01, 0xffffff6a, 0xffffff9c, 0xfffffffb, 0x000a0000 );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_RR_OP( 7,  macc.h01, 0x000001f4, 0x000001f4, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, macc.h01, 21, 0, 3, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, macc.h01, 35, 5, 5, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

