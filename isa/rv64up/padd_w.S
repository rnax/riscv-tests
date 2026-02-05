# See LICENSE for license details.

#*****************************************************************************
# padd_w.S
#-----------------------------------------------------------------------------
#
# Test padd.w instruction (packed add word with wrapping).
# Performs wrapping add on 2 x 32-bit elements: rd = rs1 + rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 0x00000004 + 0x00000006 = 0x0000000A
  TEST_RR_OP( 2,  padd.w, 0x000000000a0000000a, 0x0000000400000004, 0x0000000600000006 );
  
  # Different values: 0x10000000 + 0x20000000 = 0x30000000
  TEST_RR_OP( 3,  padd.w, 0x3000000030000000, 0x1000000010000000, 0x2000000020000000 );
  
  # Wrapping overflow: 0xFFFFFFFF + 0x00000001 = 0x00000000 (wraps)
  TEST_RR_OP( 4,  padd.w, 0x0000000000000000, 0xffffffffffffffff, 0x0000000100000001 );
  
  # Wrapping: 0x80000000 + 0x80000000 = 0x00000000 (wraps)
  TEST_RR_OP( 5,  padd.w, 0x0000000000000000, 0x8000000080000000, 0x8000000080000000 );
  
  # Negative wrapping: 0xFFFFFFFF + 0xFFFFFFFF = 0xFFFFFFFE (wraps)
  TEST_RR_OP( 6,  padd.w, 0xfffffffefffffffe, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  padd.w, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Max positive: 0x7FFFFFFF + 0x7FFFFFFF = 0xFFFFFFFE (wraps to negative)
  TEST_RR_OP( 8,  padd.w, 0xfffffffefffffffe, 0x7fffffff7fffffff, 0x7fffffff7fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, padd.w, 0x000000000a0000000a, 0x0000000400000004, 0x0000000600000006 );
  TEST_RR_SRC2_EQ_DEST( 10, padd.w, 0x000000000e0000000e, 0x0000000600000006, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, padd.w, 0x0000000a0000000a, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

