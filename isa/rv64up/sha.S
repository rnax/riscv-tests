# See LICENSE for license details.

#*****************************************************************************
# sha.S
#-----------------------------------------------------------------------------
#
# Test sha instruction (shift arithmetic with saturation - 64-bit).
# Arithmetic shift with saturation based on shift amount in rs2[7:0]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Left shift by 1: 0x0000000000000001 << 1 = 0x0000000000000002
  TEST_RR_OP( 2,  sha, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  
  # Left shift by 4: 0x0000000000000010 << 4 = 0x0000000000000100
  TEST_RR_OP( 3,  sha, 0x0000000000000100, 0x0000000000000010, 0x0000000000000004 );
  
  # Right shift by 1: 0x0000000000000010 >> 1 = 0x0000000000000008
  TEST_RR_OP( 4,  sha, 0x0000000000000008, 0x0000000000000010, 0xffffffffffffffff );
  
  # Right shift by 4: 0x0000000000000100 >> 4 = 0x0000000000000010
  TEST_RR_OP( 5,  sha, 0x0000000000000010, 0x0000000000000100, 0xfffffffffffffffc );
  
  # Negative right shift by 1: 0xffffffffffffffff >> 1 = 0xffffffffffffffff
  TEST_RR_OP( 6,  sha, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Shift amount >= 64: result is 0
  TEST_RR_OP( 7,  sha, 0x0000000000000000, 0x0000000000000001, 0x0000000000000040 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, sha, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  TEST_RR_SRC2_EQ_DEST( 9, sha, 0x0000000000000008, 0x0000000000000010, 0xffffffffffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

