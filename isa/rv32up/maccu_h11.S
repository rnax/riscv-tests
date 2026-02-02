# See LICENSE for license details.

#*****************************************************************************
# maccu_h11.S
#-----------------------------------------------------------------------------
#
# Test maccu.h11 instruction (multiply-accumulate unsigned halfword 11).
# rd = rd + zext(rs1[31:16]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_RR_OP( 2,  maccu.h11, 0x00000015, 0x00000000, 0x00030000, 0x00070000 );
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_RR_OP( 3,  maccu.h11, 0x00000096, 0x00000064, 0x00050000, 0x000a0000 );
  
  # Unsigned multiply: 1000 + 0xfff6 * 0x0014 = 1311520
  TEST_RR_OP( 4,  maccu.h11, 0x0013f6e0, 0x000003e8, 0xfff60000, 0x00140000 );
  
  # Halfword selection (upper 16 bits of both): 0 + 0x0005 * 0x000a = 50
  TEST_RR_OP( 5,  maccu.h11, 0x00000032, 0x00000000, 0x00051234, 0x000a5678 );
  
  # Unsigned multiply with high bits: 100 + 0xfffb * 0x000a = 655410
  TEST_RR_OP( 6,  maccu.h11, 0x0009fdb2, 0x00000064, 0xfffb0000, 0x000a0000 );
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_RR_OP( 7,  maccu.h11, 0x000001f4, 0x000001f4, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, maccu.h11, 21, 0, 0x00030000, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, maccu.h11, 35, 5, 0x00050000, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

