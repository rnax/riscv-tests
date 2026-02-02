# See LICENSE for license details.

#*****************************************************************************
# mhaccu.S
#-----------------------------------------------------------------------------
#
# Test mhaccu instruction (high multiply-accumulate unsigned).
# rd = rd + (rs1 * rs2) >> 32 (both unsigned)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulation: 0 + (3 * 7) >> 32 = 0
  TEST_RR_OP( 2,  mhaccu, 0x00000000, 0x00000003, 0x00000007 );
  
  # Accumulate to existing value: 100 + (5 * 10) >> 32 = 100
  TEST_RR_OP( 3,  mhaccu, 0x00000064, 0x00000005, 0x0000000a );
  
  # Large accumulation: 0x100 + (0x10000 * 0x10000) >> 32 = 0x100 + 0x10000 = 0x10100
  TEST_RR_OP( 4,  mhaccu, 0x00010100, 0x00010000, 0x00010000 );
  
  # Unsigned operands: 50 + (0xfffffffb * 0x0000000a) >> 32 = 50 + 0xfffffffe = 49
  TEST_RR_OP( 5,  mhaccu, 0x00000031, 0xfffffffb, 0x0000000a );
  
  # Unsigned * Unsigned: 200 + (0xfffffff6 * 0xffffffec) >> 32 = 200 + 0xfffffef1 = 0xfffffef9
  TEST_RR_OP( 6,  mhaccu, 0xfffffef9, 0xfffffff6, 0xffffffec );
  
  # Zero multiply: 500 + (0 * 100) >> 32 = 500
  TEST_RR_OP( 7,  mhaccu, 0x000001f4, 0x00000000, 0x00000064 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

