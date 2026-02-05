# See LICENSE for license details.

#*****************************************************************************
# paadd_h.S
#-----------------------------------------------------------------------------
#
# Test paadd_h instruction (packed averaging add halfwords).
# Performs signed averaging add on 2 x 16-bit elements: rd = (rs1 + rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (0x0004 + 0x0006) >> 1 = 0x0005
  TEST_RR_OP( 2,  paadd.h, 0x00050005, 0x00040004, 0x00060006 );
  
  # Different values: (0x1000 + 0x2000) >> 1 = 0x1800
  TEST_RR_OP( 3,  paadd.h, 0x18001800, 0x10001000, 0x20002000 );
  
  # Odd sum truncation: (3 + 4) >> 1 = 3
  TEST_RR_OP( 4,  paadd.h, 0x00030003, 0x00030003, 0x00040004 );
  
  # Negative numbers: (-4 + 6) >> 1 = 1 (signed)
  TEST_RR_OP( 5,  paadd.h, 0x00010001, 0xfffc fffc, 0x00060006 );
  
  # All negative: (-10 + -20) >> 1 = -15
  TEST_RR_OP( 6,  paadd.h, 0xfff1fff1, 0xfff6fff6, 0xffecffec );
  
  # Zero cases
  TEST_RR_OP( 7,  paadd.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max positive: (0x7FFF + 0x7FFF) >> 1 = 0x7FFF
  TEST_RR_OP( 8,  paadd.h, 0x7fff7fff, 0x7fff7fff, 0x7fff7fff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, paadd.h, 0x00050005, 0x00040004, 0x00060006 );
  TEST_RR_SRC2_EQ_DEST( 10, paadd.h, 0x00070007, 0x00060006, 0x00080008 );
  TEST_RR_SRC12_EQ_DEST( 11, paadd.h, 0x000a000a, 0x000a000a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

