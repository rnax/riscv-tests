# See LICENSE for license details.

#*****************************************************************************
# pasub_w.S
#-----------------------------------------------------------------------------
#
# Test pasub.w instruction (packed averaging subtract word).
# Performs signed averaging subtract on 2 x 32-bit elements: rd = (rs1 - rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging subtract: (0x00000008 - 0x00000002) >> 1 = 0x00000003
  TEST_RR_OP( 2,  pasub.w, 0x0000000300000003, 0x0000000800000008, 0x0000000200000002 );
  
  # Different values: (0x30000000 - 0x10000000) >> 1 = 0x08000000
  TEST_RR_OP( 3,  pasub.w, 0x0800000008000000, 0x3000000030000000, 0x1000000010000000 );
  
  # Odd difference truncation: (7 - 2) >> 1 = 2
  TEST_RR_OP( 4,  pasub.w, 0x0000000200000002, 0x0000000700000007, 0x0000000200000002 );
  
  # Negative result: (2 - 8) >> 1 = -3 (signed)
  TEST_RR_OP( 5,  pasub.w, 0xfffffffdfffffffd, 0x0000000200000002, 0x0000000800000008 );
  
  # Both negative: (-10 - -20) >> 1 = 5
  TEST_RR_OP( 6,  pasub.w, 0x0000000500000005, 0xfffffff6fffffff6, 0xffffffecffffffec );
  
  # Zero cases
  TEST_RR_OP( 7,  pasub.w, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Max positive: (0x7FFFFFFF - 0x00000000) >> 1 = 0x3FFFFFFF
  TEST_RR_OP( 8,  pasub.w, 0x3fffffff3fffffff, 0x7fffffff7fffffff, 0x0000000000000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, pasub.w, 0x0000000300000003, 0x0000000800000008, 0x0000000200000002 );
  TEST_RR_SRC2_EQ_DEST( 10, pasub.w, 0xfffffffdfffffffd, 0x0000000200000002, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, pasub.w, 0x0000000000000000, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

