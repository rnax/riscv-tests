# See LICENSE for license details.

#*****************************************************************************
# paaddu_h.S
#-----------------------------------------------------------------------------
#
# Test paaddu_h instruction (packed unsigned averaging add halfwords).
# Performs unsigned averaging add on 2 x 16-bit elements: rd = (rs1 + rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned averaging add: (0x0004 + 0x0006) >> 1 = 0x0005
  TEST_RR_OP( 2,  paaddu.h, 0x00050005, 0x00040004, 0x00060006 );
  
  # Different values: (0x1000 + 0x2000) >> 1 = 0x1800
  TEST_RR_OP( 3,  paaddu.h, 0x18001800, 0x10001000, 0x20002000 );
  
  # Odd sum truncation: (3 + 4) >> 1 = 3
  TEST_RR_OP( 4,  paaddu.h, 0x00030003, 0x00030003, 0x00040004 );
  
  # Large unsigned: (0xFFFE + 0xFFFE) >> 1 = 0x7FFF
  TEST_RR_OP( 5,  paaddu.h, 0x7fff7fff, 0xfffefffe, 0xfffefffe );
  
  # Max unsigned: (0xFFFF + 0xFFFF) >> 1 = 0x7FFF
  TEST_RR_OP( 6,  paaddu.h, 0x7fff7fff, 0xffffffff, 0xffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  paaddu.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # Mixed: (0x8000 + 0x0000) >> 1 = 0x4000
  TEST_RR_OP( 8,  paaddu.h, 0x40004000, 0x80008000, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, paaddu.h, 0x00050005, 0x00040004, 0x00060006 );
  TEST_RR_SRC2_EQ_DEST( 10, paaddu.h, 0x00070007, 0x00060006, 0x00080008 );
  TEST_RR_SRC12_EQ_DEST( 11, paaddu.h, 0x000a000a, 0x000a000a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

