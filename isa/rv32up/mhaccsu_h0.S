# See LICENSE for license details.

#*****************************************************************************
# mhaccsu_h0.S
#-----------------------------------------------------------------------------
#
# Test mhaccsu.h0 instruction (high multiply-accumulate signed*unsigned halfword 0).
# rd = rd + (rs1 * rs2[15:0]) >> 32 (rs1 signed, rs2[15:0] unsigned)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + (3 * 7) >> 32 = 0
  TEST_RR_OP( 2,  mhaccsu.h0, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100
  TEST_RR_OP( 3,  mhaccsu.h0, 0x00000064, 0x00000005, 0x0000000a );
  
  # Large accumulation with halfword: 0x100 + (0x10000 * 0x0000) >> 32 = 0x100
  TEST_RR_OP( 4,  mhaccsu.h0, 0x00000100, 0x00010000, 0x00010000 );
  
  # Negative signed * Positive unsigned: 50 + ((-5) * 10) >> 32 = 50 + 0xffffffff = 49
  TEST_RR_OP( 5,  mhaccsu.h0, 0x00000031, 0xfffffffb, 0x0000000a );
  
  # Negative signed * Negative unsigned (treated as large positive): 200 + ((-10) * 0xffec) >> 32
  TEST_RR_OP( 6,  mhaccsu.h0, 0x00000027, 0xfffffff6, 0xffffffec );
  
  # Zero multiply: 500 + (0 * 100) >> 32 = 500
  TEST_RR_OP( 7,  mhaccsu.h0, 0x000001f4, 0x00000000, 0x00000064 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

