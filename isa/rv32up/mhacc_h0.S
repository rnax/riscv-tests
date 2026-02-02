# See LICENSE for license details.

#*****************************************************************************
# mhacc_h0.S
#-----------------------------------------------------------------------------
#
# Test mhacc.h0 instruction (high multiply-accumulate halfword 0).
# rd = rd + (rs1 * rs2[15:0]) >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + (3 * 7) >> 32 = 0
  TEST_RR_OP( 2,  mhacc.h0, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100
  TEST_RR_OP( 3,  mhacc.h0, 0x00000064, 0x00000005, 0x0000000a );
  
  # Large accumulation with halfword: 0x100 + (0x10000 * 0x0000) >> 32 = 0x100
  TEST_RR_OP( 4,  mhacc.h0, 0x00000100, 0x00010000, 0x00010000 );
  
  # Negative operands: 50 + ((-5) * 10) >> 32 = 50 + 0xffffffff = 49
  TEST_RR_OP( 5,  mhacc.h0, 0x00000031, 0xfffffffb, 0x0000000a );
  
  # Negative * Negative: 200 + ((-10) * (-20)) >> 32 = 200 + 0 = 200
  TEST_RR_OP( 6,  mhacc.h0, 0x000000c8, 0xfffffff6, 0xffffffec );
  
  # Zero multiply: 500 + (0 * 100) >> 32 = 500
  TEST_RR_OP( 7,  mhacc.h0, 0x000001f4, 0x00000000, 0x00000064 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

