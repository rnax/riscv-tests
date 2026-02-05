# See LICENSE for license details.

#*****************************************************************************
# paas_wx.S
#-----------------------------------------------------------------------------
#
# Test paas.wx instruction (packed add-sub cross word).
# Performs add on lower word and sub on upper word: 
# rd[31:0] = (rs1[31:0] + rs2[31:0]) >> 1
# rd[63:32] = (rs1[63:32] - rs2[63:32]) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross operation: lower add (4+6)>>1=5, upper sub (8-2)>>1=3
  TEST_RR_OP( 2,  paas.wx, 0x0000000300000005, 0x0000000800000004, 0x0000000200000006 );
  
  # Different values: lower add (10+20)>>1=15, upper sub (30-10)>>1=10
  TEST_RR_OP( 3,  paas.wx, 0x000000000a00000f, 0x000000001e0000000a, 0x000000000a00000014 );
  
  # Odd sums: lower (3+4)>>1=3, upper (7-2)>>1=2
  TEST_RR_OP( 4,  paas.wx, 0x0000000200000003, 0x0000000700000003, 0x0000000200000004 );
  
  # Negative lower: lower (-4+6)>>1=1, upper (8-2)>>1=3
  TEST_RR_OP( 5,  paas.wx, 0x0000000300000001, 0x0000000800000004, 0x0000000200000006 );
  
  # Negative upper: lower (4+6)>>1=5, upper (-8-2)>>1=-5
  TEST_RR_OP( 6,  paas.wx, 0xfffffffb00000005, 0xfffffff800000004, 0x0000000200000006 );
  
  # Zero cases
  TEST_RR_OP( 7,  paas.wx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Max values: lower (0x7FFFFFFF+0x7FFFFFFF)>>1=0x7FFFFFFF, upper (0x7FFFFFFF-0x00000000)>>1=0x3FFFFFFF
  TEST_RR_OP( 8,  paas.wx, 0x3fffffff7fffffff, 0x7fffffff7fffffff, 0x000000007fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, paas.wx, 0x0000000300000005, 0x0000000800000004, 0x0000000200000006 );
  TEST_RR_SRC2_EQ_DEST( 10, paas.wx, 0xfffffffd00000007, 0x0000000600000006, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, paas.wx, 0x0000000000000005, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

