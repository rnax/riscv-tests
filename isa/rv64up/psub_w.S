# See LICENSE for license details.

#*****************************************************************************
# psub_w.S
#-----------------------------------------------------------------------------
#
# Test psub.w instruction (packed subtract word with wrapping).
# Performs wrapping subtract on 2 x 32-bit elements: rd = rs1 - rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 0x00000008 - 0x00000002 = 0x00000006
  TEST_RR_OP( 2,  psub.w, 0x0000000600000006, 0x0000000800000008, 0x0000000200000002 );
  
  # Different values: 0x30000000 - 0x10000000 = 0x20000000
  TEST_RR_OP( 3,  psub.w, 0x2000000020000000, 0x3000000030000000, 0x1000000010000000 );
  
  # Wrapping underflow: 0x00000000 - 0x00000001 = 0xFFFFFFFF (wraps)
  TEST_RR_OP( 4,  psub.w, 0xffffffffffffffff, 0x0000000000000000, 0x0000000100000001 );
  
  # Wrapping: 0x80000000 - 0x80000000 = 0x00000000
  TEST_RR_OP( 5,  psub.w, 0x0000000000000000, 0x8000000080000000, 0x8000000080000000 );
  
  # Negative wrapping: 0xFFFFFFFF - 0xFFFFFFFF = 0x00000000
  TEST_RR_OP( 6,  psub.w, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero cases
  TEST_RR_OP( 7,  psub.w, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Max positive: 0x7FFFFFFF - 0x00000000 = 0x7FFFFFFF
  TEST_RR_OP( 8,  psub.w, 0x7fffffff7fffffff, 0x7fffffff7fffffff, 0x0000000000000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 9, psub.w, 0x0000000600000006, 0x0000000800000008, 0x0000000200000002 );
  TEST_RR_SRC2_EQ_DEST( 10, psub.w, 0xfffffffefffffffe, 0x0000000200000002, 0x0000000800000008 );
  TEST_RR_SRC12_EQ_DEST( 11, psub.w, 0x0000000000000000, 0x0000000500000005 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

