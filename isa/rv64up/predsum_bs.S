# See LICENSE for license details.

#*****************************************************************************
# predsum_bs.S
#-----------------------------------------------------------------------------
#
# Test predsum.bs instruction (packed reduction sum signed byte).
# Sums all 4 signed bytes from rs1: rd = sum(rs1[7:0], rs1[15:8], rs1[23:16], rs1[31:24])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum signed byte tests
  #-------------------------------------------------------------

  # Basic sum: 1+2+3+4 = 10
  TEST_RR_OP( 2,  predsum.bs, 0x0000000a, 0x04030201, 0x00000000 );
  
  # All zeros
  TEST_RR_OP( 3,  predsum.bs, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  predsum.bs, 0x00000004, 0x01010101, 0x00000000 );
  
  # Negative values: -1 * 4 = -4
  TEST_RR_OP( 5,  predsum.bs, 0xfffffffc, 0xffffffff, 0x00000000 );
  
  # Mixed positive and negative: 10 + (-5) + 20 + (-10) = 15
  TEST_RR_OP( 6,  predsum.bs, 0x0000000f, 0xfbfb0a0a, 0x00000000 );
  
  # Large positive values: 100+100+100+100 = 400
  TEST_RR_OP( 7,  predsum.bs, 0x00000190, 0x64646464, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


