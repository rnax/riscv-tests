# See LICENSE for license details.

#*****************************************************************************
# predsum_hs.S
#-----------------------------------------------------------------------------
#
# Test predsum.hs instruction (packed reduction sum signed halfword).
# Sums all 2 signed halfwords from rs1: rd = sum(rs1[15:0], rs1[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum signed halfword tests
  #-------------------------------------------------------------

  # Basic sum: 0x0001 + 0x0002 = 0x0003
  TEST_RR_OP( 2,  predsum.hs, 0x00000003, 0x00020001, 0x00000000 );
  
  # All zeros
  TEST_RR_OP( 3,  predsum.hs, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  predsum.hs, 0x00000002, 0x00010001, 0x00000000 );
  
  # Negative values: -1 + -1 = -2
  TEST_RR_OP( 5,  predsum.hs, 0xfffffffe, 0xffffffff, 0x00000000 );
  
  # Mixed positive and negative: 1000 + (-500) = 500
  TEST_RR_OP( 6,  predsum.hs, 0x000001f4, 0xfe0c03e8, 0x00000000 );
  
  # Large positive values: 10000 + 10000 = 20000
  TEST_RR_OP( 7,  predsum.hs, 0x00004e20, 0x27102710, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


