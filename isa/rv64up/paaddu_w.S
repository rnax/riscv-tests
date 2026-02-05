# See LICENSE for license details.

#*****************************************************************************
# paaddu_w.S
#-----------------------------------------------------------------------------
#
# Test paaddu.w instruction (packed unsigned averaging add word).
# Performs unsigned averaging add on 2 x 32-bit elements: rd = (rs1 + rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (0x00000004 + 0x00000006) >> 1 = 0x00000005
  TEST_RR_OP( 2,  paaddu.w, 0x0000000500000005, 0x0000000400000004, 0x0000000600000006 );
  
  # Different values: (0x10000000 + 0x20000000) >> 1 = 0x18000000
  TEST_RR_OP( 3,  paaddu.w, 0x1800000018000000, 0x1000000010000000, 0x2000000020000000 );
  
  # Odd sum truncation: (3 + 4) >> 1 = 3
  TEST_RR_OP( 4,  paaddu.w, 0x0000000300000003, 0x0000000300000003, 0x0000000400000004 );
  
  # Large unsigned values: (0xFFFFFFFE + 0xFFFFFFFF) >> 1 = 0xFFFFFFFF
  TEST_RR_OP( 5,  paaddu.w, 0xffffffffffffffff, 0xfffffffefffffffe, 0xffffffffffffffff );
  
  # Max unsigned: (0xFFFFFFFF + 0xFFFFFFFF) >> 1 = 0xFFFFFFFF
  TEST_RR_OP( 6,  paaddu.w, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  paaddu.w, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # High bit set: (0x80000000 + 0x80000000) >> 1 = 0x80000000
  TEST_RR_OP( 8,  paaddu.w, 0x8000000080000000, 0x8000000080000000, 0x8000000080000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, paaddu.w, 0x0000000500000005, 0x0000000400000004, 0x0000000600000006 );
  TEST_RR_SRC2_EQ_DEST( 10, paaddu.w, 0x0000000700000007, 0x0000000600000006, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, paaddu.w, 0x0000000500000005, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

