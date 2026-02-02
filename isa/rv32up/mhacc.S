# See LICENSE for license details.

#*****************************************************************************
# mhacc.S
#-----------------------------------------------------------------------------
#
# Test mhacc instruction (high multiply-accumulate signed).
# rd = rd + (rs1 * rs2) >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + (3 * 7) >> 32 = 0
  TEST_RR_OP( 2,  mhacc, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100
  TEST_RR_OP( 3,  mhacc, 0x00000064, 0x00000005, 0x0000000a );
  
  # Large accumulation: 0x100 + (0x10000 * 0x10000) >> 32 = 0x100 + 0x10000 = 0x10100
  TEST_RR_OP( 4,  mhacc, 0x00010100, 0x00010000, 0x00010000 );
  
  # Negative operands: 50 + ((-5) * 10) >> 32 = 50 + 0xffffffff = 49
  TEST_RR_OP( 5,  mhacc, 0x00000031, 0xfffffffb, 0x0000000a );
  
  # Negative * Negative: 200 + ((-10) * (-20)) >> 32 = 200 + 0 = 200
  TEST_RR_OP( 6,  mhacc, 0x000000c8, 0xfffffff6, 0xffffffec );
  
  # Zero multiply: 500 + (0 * 100) >> 32 = 500
  TEST_RR_OP( 7,  mhacc, 0x000001f4, 0x00000000, 0x00000064 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

