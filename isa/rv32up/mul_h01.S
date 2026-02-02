# See LICENSE for license details.

#*****************************************************************************
# mul_h01.S
#-----------------------------------------------------------------------------
#
# Test mul.h01 instruction (multiply halfword 01).
# rd = sext(rs1[15:0]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mul.h01, 0x00000015, 0x00000003, 0x00070000 );
  
  # Multiply with larger values: 100 * 50 = 5000
  TEST_RR_OP( 3,  mul.h01, 0x00001388, 0x00000064, 0x00320000 );
  
  # Negative multiply: (-10) * 20 = -200
  TEST_RR_OP( 4,  mul.h01, 0xffffff38, 0xfffffff6, 0x00140000 );
  
  # Halfword selection (lower 16 bits of rs1, upper 16 bits of rs2): 0x0005 * 0x5678 = 22136
  TEST_RR_OP( 5,  mul.h01, 0x000056b8, 0x12340005, 0x56780000 );
  
  # Negative result: (-5) * 10 = -50
  TEST_RR_OP( 6,  mul.h01, 0xffffffce, 0xfffffffb, 0x000a0000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  mul.h01, 0x00000000, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mul.h01, 21, 3, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, mul.h01, 35, 5, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

