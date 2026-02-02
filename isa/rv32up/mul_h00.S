# See LICENSE for license details.

#*****************************************************************************
# mul_h00.S
#-----------------------------------------------------------------------------
#
# Test mul.h00 instruction (multiply halfword 00).
# rd = sext(rs1[15:0]) * sext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mul.h00, 0x00000015, 0x00000003, 0x00000007 );
  
  # Multiply with larger values: 100 * 50 = 5000
  TEST_RR_OP( 3,  mul.h00, 0x00001388, 0x00000064, 0x00000032 );
  
  # Negative multiply: (-10) * 20 = -200
  TEST_RR_OP( 4,  mul.h00, 0xffffff38, 0xfffffff6, 0x00000014 );
  
  # Halfword selection (lower 16 bits): 0x0005 * 0x000a = 50
  TEST_RR_OP( 5,  mul.h00, 0x00000032, 0x12340005, 0x5678000a );
  
  # Negative result: (-5) * 10 = -50
  TEST_RR_OP( 6,  mul.h00, 0xffffffce, 0xfffffffb, 0x0000000a );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  mul.h00, 0x00000000, 0x00000000, 0x00000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mul.h00, 21, 3, 7 );
  TEST_RR_SRC2_EQ_DEST( 9, mul.h00, 35, 5, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

