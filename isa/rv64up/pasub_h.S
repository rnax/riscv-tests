# See LICENSE for license details.

#*****************************************************************************
# pasub_h.S
#-----------------------------------------------------------------------------
#
# Test pasub_h instruction (packed averaging subtract halfwords).
# Performs signed averaging subtract on 2 x 16-bit elements: rd = (rs1 - rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging subtract: (0x000A - 0x0004) >> 1 = 0x0003
  TEST_RR_OP( 2,  pasub.h, 0x00030003, 0x000a000a, 0x00040004 );
  
  # Different values: (0x3000 - 0x1000) >> 1 = 0x1000
  TEST_RR_OP( 3,  pasub.h, 0x10001000, 0x30003000, 0x10001000 );
  
  # Odd difference truncation: (5 - 2) >> 1 = 1
  TEST_RR_OP( 4,  pasub.h, 0x00010001, 0x00050005, 0x00020002 );
  
  # Negative result: (4 - 10) >> 1 = -3
  TEST_RR_OP( 5,  pasub.h, 0xfffdfffd, 0x00040004, 0x000a000a );
  
  # All negative: (-10 - -20) >> 1 = 5
  TEST_RR_OP( 6,  pasub.h, 0x00050005, 0xfff6fff6, 0xffecffec );
  
  # Zero cases
  TEST_RR_OP( 7,  pasub.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max positive: (0x7FFF - 0x0000) >> 1 = 0x3FFF
  TEST_RR_OP( 8,  pasub.h, 0x3fff3fff, 0x7fff7fff, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, pasub.h, 0x00030003, 0x000a000a, 0x00040004 );
  TEST_RR_SRC2_EQ_DEST( 10, pasub.h, 0xfffdfffd, 0x00040004, 0x000a000a );
  TEST_RR_SRC12_EQ_DEST( 11, pasub.h, 0x00000000, 0x000a000a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

