# See LICENSE for license details.

#*****************************************************************************
# paadd_b.S
#-----------------------------------------------------------------------------
#
# Test paadd_b instruction (packed averaging add bytes).
# Performs signed averaging add on 4 x 8-bit elements: rd = (rs1 + rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (4 + 6) >> 1 = 5 in each byte
  TEST_RR_OP( 2,  paadd.b, 0x05050505, 0x04040404, 0x06060606 );
  
  # Different values per byte: (0x10 + 0x20) >> 1 = 0x18
  TEST_RR_OP( 3,  paadd.b, 0x18181818, 0x10101010, 0x20202020 );
  
  # Odd sum truncation: (3 + 4) >> 1 = 3
  TEST_RR_OP( 4,  paadd.b, 0x03030303, 0x03030303, 0x04040404 );
  
  # Negative numbers: (-4 + 6) >> 1 = 1 (signed)
  TEST_RR_OP( 5,  paadd.b, 0x01010101, 0xfcfcfcfc, 0x06060606 );
  
  # All negative: (-10 + -20) >> 1 = -15
  TEST_RR_OP( 6,  paadd.b, 0xf1f1f1f1, 0xf6f6f6f6, 0xececec );
  
  # Zero cases
  TEST_RR_OP( 7,  paadd.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max positive: (0x7F + 0x7F) >> 1 = 0x7F
  TEST_RR_OP( 8,  paadd.b, 0x7f7f7f7f, 0x7f7f7f7f, 0x7f7f7f7f );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, paadd.b, 0x05050505, 0x04040404, 0x06060606 );
  TEST_RR_SRC2_EQ_DEST( 10, paadd.b, 0x07070707, 0x06060606, 0x08080808 );
  TEST_RR_SRC12_EQ_DEST( 11, paadd.b, 0x0a0a0a0a, 0x0a0a0a0a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

