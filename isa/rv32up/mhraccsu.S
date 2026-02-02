# See LICENSE for license details.

#*****************************************************************************
# mhraccsu.S
#-----------------------------------------------------------------------------
#
# Test mhraccsu instruction (high multiply-accumulate signed*unsigned with rounding).
# rd = rd + round((rs1 * rs2) >> 31) (rs1 signed, rs2 unsigned)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + round((3 * 7) >> 31) = 0
  TEST_RR_OP( 2,  mhraccsu, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + round((5 * 10) >> 31) = 100
  TEST_RR_OP( 3,  mhraccsu, 0x00000064, 0x00000005, 0x0000000a );
  
  # Large accumulation: 0x100 + round((0x10000 * 0x10000) >> 31) = 0x100 + 0x20000 = 0x20100
  TEST_RR_OP( 4,  mhraccsu, 0x00020100, 0x00010000, 0x00010000 );
  
  # Negative signed * Positive unsigned: 50 + round(((-5) * 10) >> 31) = 50 + 0xffffffff = 49
  TEST_RR_OP( 5,  mhraccsu, 0x00000031, 0xfffffffb, 0x0000000a );
  
  # Negative signed * Negative unsigned (treated as large positive): 200 + round(((-10) * 0xffffffec) >> 31)
  TEST_RR_OP( 6,  mhraccsu, 0x00000027, 0xfffffff6, 0xffffffec );
  
  # Zero multiply: 500 + round((0 * 100) >> 31) = 500
  TEST_RR_OP( 7,  mhraccsu, 0x000001f4, 0x00000000, 0x00000064 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

