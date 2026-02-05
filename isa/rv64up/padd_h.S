# See LICENSE for license details.

#*****************************************************************************
# padd_h.S
#-----------------------------------------------------------------------------
#
# Test padd_h instruction (packed add halfwords with wrapping).
# Performs wrapping add on 2 x 16-bit elements: rd = rs1 + rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 0x0004 + 0x0006 = 0x000A
  TEST_RR_OP( 2,  padd.h, 0x000a000a, 0x00040004, 0x00060006 );
  
  # Different values: 0x1000 + 0x2000 = 0x3000
  TEST_RR_OP( 3,  padd.h, 0x30003000, 0x10001000, 0x20002000 );
  
  # Wrapping overflow: 0xFFFF + 0x0001 = 0x0000 (wraps)
  TEST_RR_OP( 4,  padd.h, 0x00000000, 0xffffffff, 0x00010001 );
  
  # Wrapping: 0x8000 + 0x8000 = 0x0000 (wraps)
  TEST_RR_OP( 5,  padd.h, 0x00000000, 0x80008000, 0x80008000 );
  
  # Negative wrapping: 0xFFFF + 0xFFFF = 0xFFFE (wraps)
  TEST_RR_OP( 6,  padd.h, 0xfffffffe, 0xffffffff, 0xffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  padd.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # Max positive: 0x7FFF + 0x7FFF = 0xFFFE (wraps to negative)
  TEST_RR_OP( 8,  padd.h, 0xfffffffe, 0x7fff7fff, 0x7fff7fff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, padd.h, 0x000a000a, 0x00040004, 0x00060006 );
  TEST_RR_SRC2_EQ_DEST( 10, padd.h, 0x000e000e, 0x00060006, 0x00080008 );
  TEST_RR_SRC12_EQ_DEST( 11, padd.h, 0x00140014, 0x000a000a );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

