# See LICENSE for license details.

#*****************************************************************************
# pas_wx.S
#-----------------------------------------------------------------------------
#
# Test pas.wx instruction (packed add-sub word).
# Performs add on lower word and sub on upper word:
# rd[31:0] = rs1[31:0] + rs2[31:0]
# rd[63:32] = rs1[63:32] - rs2[63:32]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross operation: lower add (4+6)=10, upper sub (8-2)=6
  TEST_RR_OP( 2,  pas.wx, 0x000000060000000a, 0x0000000800000004, 0x0000000200000006 );
  
  # Different values: lower add (10+20)=30, upper sub (30-10)=20
  TEST_RR_OP( 3,  pas.wx, 0x000000140000001e, 0x000000001e0000000a, 0x000000000a00000014 );
  
  # Wrapping lower: lower (0xFFFFFFFF+0x00000001)=0x00000000, upper (8-2)=6
  TEST_RR_OP( 4,  pas.wx, 0x0000000600000000, 0x0000000800000008, 0x0000000200000001 );
  
  # Wrapping upper: lower (4+6)=10, upper (0x00000000-0x00000001)=0xFFFFFFFF
  TEST_RR_OP( 5,  pas.wx, 0xffffffff0000000a, 0x0000000400000004, 0x0000000100000006 );
  
  # Negative values: lower (-4+6)=2, upper (-8-2)=-10
  TEST_RR_OP( 6,  pas.wx, 0xfffffff600000002, 0xfffffff800000004, 0x0000000200000006 );
  
  # Zero cases
  TEST_RR_OP( 7,  pas.wx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Max values: lower (0x7FFFFFFF+0x7FFFFFFF)=0xFFFFFFFE, upper (0x7FFFFFFF-0x00000000)=0x7FFFFFFF
  TEST_RR_OP( 8,  pas.wx, 0x7ffffffffffffffe, 0x7fffffff7fffffff, 0x000000007fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, pas.wx, 0x000000060000000a, 0x0000000800000004, 0x0000000200000006 );
  TEST_RR_SRC2_EQ_DEST( 10, pas.wx, 0xfffffffe0000000e, 0x0000000600000006, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, pas.wx, 0x0000000000000005, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

