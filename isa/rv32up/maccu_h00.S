# See LICENSE for license details.

#*****************************************************************************
# maccu_h00.S
#-----------------------------------------------------------------------------
#
# Test maccu.h00 instruction (multiply-accumulate unsigned halfword 00).
# rd = rd + zext(rs1[15:0]) * zext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_RR_OP( 2,  maccu.h00, 0x00000015, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_RR_OP( 3,  maccu.h00, 0x00000096, 0x00000064, 0x00000005, 0x0000000a );
  
  # Unsigned multiply: 1000 + 0xfff6 * 0x0014 = 1000 + 65526 * 20 = 1000 + 1310520 = 1311520
  TEST_RR_OP( 4,  maccu.h00, 0x0013f6e0, 0x000003e8, 0xfffffff6, 0x00000014 );
  
  # Halfword selection (lower 16 bits): 0 + 0x0005 * 0x000a = 50
  TEST_RR_OP( 5,  maccu.h00, 0x00000032, 0x00000000, 0x12340005, 0x5678000a );
  
  # Unsigned multiply with high bits: 100 + 0xfffb * 0x000a = 100 + 65531 * 10 = 100 + 655310 = 655410
  TEST_RR_OP( 6,  maccu.h00, 0x0009fdb2, 0x00000064, 0xfffffffb, 0x0000000a );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_RR_OP( 7,  maccu.h00, 0x000001f4, 0x000001f4, 0x00000000, 0x00000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, maccu.h00, 21, 0, 3, 7 );
  TEST_RR_SRC2_EQ_DEST( 9, maccu.h00, 35, 5, 5, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

