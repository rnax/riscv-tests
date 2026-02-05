# See LICENSE for license details.

#*****************************************************************************
# shar.S
#-----------------------------------------------------------------------------
#
# Test shar instruction (shift arithmetic with rounding - 64-bit).
# Arithmetic shift with rounding based on shift amount in rs2[7:0]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Left shift by 1: 0x0000000000000001 << 1 = 0x0000000000000002
  TEST_RR_OP( 2,  shar, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  
  # Left shift by 4: 0x0000000000000010 << 4 = 0x0000000000000100
  TEST_RR_OP( 3,  shar, 0x0000000000000100, 0x0000000000000010, 0x0000000000000004 );
  
  # Right shift by 1 with rounding: 0x0000000000000011 >> 1 = 0x0000000000000009 (rounded)
  TEST_RR_OP( 4,  shar, 0x0000000000000009, 0x0000000000000011, 0xffffffffffffffff );
  
  # Right shift by 4: 0x0000000000000100 >> 4 = 0x0000000000000010
  TEST_RR_OP( 5,  shar, 0x0000000000000010, 0x0000000000000100, 0xfffffffffffffffc );
  
  # Negative right shift by 1 with rounding: 0xffffffffffffffff >> 1 = 0xffffffffffffffff
  TEST_RR_OP( 6,  shar, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Shift amount >= 64: result is 0
  TEST_RR_OP( 7,  shar, 0x0000000000000000, 0x0000000000000001, 0x0000000000000040 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, shar, 0x0000000000000002, 0x0000000000000001, 0x0000000000000001 );
  TEST_RR_SRC2_EQ_DEST( 9, shar, 0x0000000000000009, 0x0000000000000011, 0xffffffffffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

