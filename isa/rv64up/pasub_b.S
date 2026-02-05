# See LICENSE for license details.

#*****************************************************************************
# pasub_b.S
#-----------------------------------------------------------------------------
#
# Test pasub_b instruction (packed averaging subtract bytes).
# Performs signed averaging subtract on 4 x 8-bit elements: rd = (rs1 - rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging subtract: (10 - 4) >> 1 = 3
  TEST_RR_OP( 2,  pasub.b, 0x03030303, 0x0a0a0a0a, 0x04040404 );
  
  # Different values: (0x30 - 0x10) >> 1 = 0x10
  TEST_RR_OP( 3,  pasub.b, 0x10101010, 0x30303030, 0x10101010 );
  
  # Odd difference truncation: (5 - 2) >> 1 = 1
  TEST_RR_OP( 4,  pasub.b, 0x01010101, 0x05050505, 0x02020202 );
  
  # Negative result: (4 - 10) >> 1 = -3
  TEST_RR_OP( 5,  pasub.b, 0xfdfdfdfd, 0x04040404, 0x0a0a0a0a );
  
  # All negative: (-10 - -20) >> 1 = 5
  TEST_RR_OP( 6,  pasub.b, 0x05050505, 0xf6f6f6f6, 0xececec );
  
  # Zero cases
  TEST_RR_OP( 7,  pasub.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max positive: (0x7F - 0x00) >> 1 = 0x3F
  TEST_RR_OP( 8,  pasub.b, 0x3f3f3f3f, 0x7f7f7f7f, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, pasub.b, 0x03030303, 0x0a0a0a0a, 0x04040404 );
  TEST_RR_SRC2_EQ_DEST( 10, pasub.b, 0xfdfdfdfd, 0x04040404, 0x0a0a0a0a );
  TEST_RR_SRC12_EQ_DEST( 11, pasub.b, 0x00000000, 0x0a0a0a0a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

