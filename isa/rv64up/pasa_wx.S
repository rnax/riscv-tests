# See LICENSE for license details.

#*****************************************************************************
# pasa_wx.S
#-----------------------------------------------------------------------------
#
# Test pasa.wx instruction (packed sub-add cross word).
# Performs sub on lower word and add on upper word:
# rd[31:0] = (rs1[31:0] - rs2[31:0]) >> 1
# rd[63:32] = (rs1[63:32] + rs2[63:32]) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross operation: lower sub (8-2)>>1=3, upper add (4+6)>>1=5
  TEST_RR_OP( 2,  pasa.wx, 0x0000000500000003, 0x0000000400000008, 0x0000000600000002 );
  
  # Different values: lower sub (30-10)>>1=10, upper add (10+20)>>1=15
  TEST_RR_OP( 3,  pasa.wx, 0x000000000f0000000a, 0x000000000a0000001e, 0x0000000014000000000a );
  
  # Odd differences: lower (7-2)>>1=2, upper (3+4)>>1=3
  TEST_RR_OP( 4,  pasa.wx, 0x0000000300000002, 0x0000000300000007, 0x0000000400000002 );
  
  # Negative lower: lower (2-8)>>1=-3, upper (4+6)>>1=5
  TEST_RR_OP( 5,  pasa.wx, 0x0000000500000003, 0x0000000400000002, 0x0000000600000008 );
  
  # Negative upper: lower (8-2)>>1=3, upper (-4+6)>>1=1
  TEST_RR_OP( 6,  pasa.wx, 0x0000000100000003, 0xfffffffc00000008, 0x0000000600000002 );
  
  # Zero cases
  TEST_RR_OP( 7,  pasa.wx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Max values: lower (0x7FFFFFFF-0x00000000)>>1=0x3FFFFFFF, upper (0x7FFFFFFF+0x7FFFFFFF)>>1=0x7FFFFFFF
  TEST_RR_OP( 8,  pasa.wx, 0x7fffffff3fffffff, 0x7fffffff7fffffff, 0x000000007fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, pasa.wx, 0x0000000500000003, 0x0000000400000008, 0x0000000600000002 );
  TEST_RR_SRC2_EQ_DEST( 10, pasa.wx, 0x0000000700000003, 0x0000000600000006, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, pasa.wx, 0x0000000500000000, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

