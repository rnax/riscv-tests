# See LICENSE for license details.

#*****************************************************************************
# padd_b.S
#-----------------------------------------------------------------------------
#
# Test padd_b instruction (packed add bytes with wrapping).
# Performs wrapping add on 4 x 8-bit elements: rd = rs1 + rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 4 + 6 = 10
  TEST_RR_OP( 2,  padd.b, 0x0a0a0a0a, 0x04040404, 0x06060606 );
  
  # Different values: 0x10 + 0x20 = 0x30
  TEST_RR_OP( 3,  padd.b, 0x30303030, 0x10101010, 0x20202020 );
  
  # Wrapping overflow: 0xFF + 0x01 = 0x00 (wraps)
  TEST_RR_OP( 4,  padd.b, 0x00000000, 0xffffffff, 0x01010101 );
  
  # Wrapping: 0x80 + 0x80 = 0x00 (wraps)
  TEST_RR_OP( 5,  padd.b, 0x00000000, 0x80808080, 0x80808080 );
  
  # Negative wrapping: 0xFF + 0xFF = 0xFE (wraps)
  TEST_RR_OP( 6,  padd.b, 0xfefefefe, 0xffffffff, 0xffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  padd.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max positive: 0x7F + 0x7F = 0xFE (wraps to negative)
  TEST_RR_OP( 8,  padd.b, 0xfefefefe, 0x7f7f7f7f, 0x7f7f7f7f );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, padd.b, 0x0a0a0a0a, 0x04040404, 0x06060606 );
  TEST_RR_SRC2_EQ_DEST( 10, padd.b, 0x0e0e0e0e, 0x06060606, 0x08080808 );
  TEST_RR_SRC12_EQ_DEST( 11, padd.b, 0x14141414, 0x0a0a0a0a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

