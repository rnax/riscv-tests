# See LICENSE for license details.

#*****************************************************************************
# pasubu_b.S
#-----------------------------------------------------------------------------
#
# Test pasubu_b instruction (packed unsigned averaging subtract bytes).
# Performs unsigned averaging subtract on 4 x 8-bit elements: rd = (rs1 - rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned averaging subtract: (10 - 4) >> 1 = 3
  TEST_RR_OP( 2,  pasubu.b, 0x03030303, 0x0a0a0a0a, 0x04040404 );
  
  # Different values: (0x30 - 0x10) >> 1 = 0x10
  TEST_RR_OP( 3,  pasubu.b, 0x10101010, 0x30303030, 0x10101010 );
  
  # Odd difference truncation: (5 - 2) >> 1 = 1
  TEST_RR_OP( 4,  pasubu.b, 0x01010101, 0x05050505, 0x02020202 );
  
  # Underflow (unsigned): (0x04 - 0x0A) >> 1 = 0xFD (wraps)
  TEST_RR_OP( 5,  pasubu.b, 0xfdfdfdfd, 0x04040404, 0x0a0a0a0a );
  
  # Large unsigned: (0xFE - 0x02) >> 1 = 0x7C
  TEST_RR_OP( 6,  pasubu.b, 0x7c7c7c7c, 0xfefefefe, 0x02020202 );
  
  # Zero cases
  TEST_RR_OP( 7,  pasubu.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max unsigned: (0xFF - 0x00) >> 1 = 0x7F
  TEST_RR_OP( 8,  pasubu.b, 0x7f7f7f7f, 0xffffffff, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, pasubu.b, 0x03030303, 0x0a0a0a0a, 0x04040404 );
  TEST_RR_SRC2_EQ_DEST( 10, pasubu.b, 0xfdfdfdfd, 0x04040404, 0x0a0a0a0a );
  TEST_RR_SRC12_EQ_DEST( 11, pasubu.b, 0x00000000, 0x0a0a0a0a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

