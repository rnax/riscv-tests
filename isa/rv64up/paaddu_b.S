# See LICENSE for license details.

#*****************************************************************************
# paaddu_b.S
#-----------------------------------------------------------------------------
#
# Test paaddu_b instruction (packed unsigned averaging add bytes).
# Performs unsigned averaging add on 4 x 8-bit elements: rd = (rs1 + rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned averaging add: (4 + 6) >> 1 = 5
  TEST_RR_OP( 2,  paaddu.b, 0x05050505, 0x04040404, 0x06060606 );
  
  # Different values: (0x10 + 0x20) >> 1 = 0x18
  TEST_RR_OP( 3,  paaddu.b, 0x18181818, 0x10101010, 0x20202020 );
  
  # Odd sum truncation: (3 + 4) >> 1 = 3
  TEST_RR_OP( 4,  paaddu.b, 0x03030303, 0x03030303, 0x04040404 );
  
  # Large unsigned values: (0xFE + 0xFE) >> 1 = 0x7F
  TEST_RR_OP( 5,  paaddu.b, 0x7f7f7f7f, 0xfefefefe, 0xfefefefe );
  
  # Max unsigned: (0xFF + 0xFF) >> 1 = 0x7F
  TEST_RR_OP( 6,  paaddu.b, 0x7f7f7f7f, 0xffffffff, 0xffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  paaddu.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # Mixed: (0x80 + 0x00) >> 1 = 0x40
  TEST_RR_OP( 8,  paaddu.b, 0x40404040, 0x80808080, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, paaddu.b, 0x05050505, 0x04040404, 0x06060606 );
  TEST_RR_SRC2_EQ_DEST( 10, paaddu.b, 0x07070707, 0x06060606, 0x08080808 );
  TEST_RR_SRC12_EQ_DEST( 11, paaddu.b, 0x0a0a0a0a, 0x0a0a0a0a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

