# See LICENSE for license details.

#*****************************************************************************
# pmhaccsu_h_b1.S
#-----------------------------------------------------------------------------
#
# Test pmhaccsu.h.b1 instruction (packed multiply high accumulate signed*unsigned top).
# Performs 16-bit signed*unsigned multiply on upper halfwords and accumulates high 32-bit result.
# rd = rd + (sext(rs1[31:16]) * zext(rs2[31:16])) >> 16
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + (3 * 7) >> 16 = 0
  TEST_RR_OP( 2,  pmhaccsu.h.b1, 0x00000000, 0x00030000, 0x00070000 );
  
  # Accumulate to existing value: 100 + (5 * 10) >> 16 = 100
  TEST_RR_OP( 3,  pmhaccsu.h.b1, 0x00000064, 0x00050000, 0x000a0000 );
  
  # Signed negative, unsigned positive: 0x100 + ((-10) * 20) >> 16 = 0x100 + 0xffffffff = 0xff
  TEST_RR_OP( 4,  pmhaccsu.h.b1, 0x000000ff, 0xfff60000, 0x00140000 );
  
  # Mixed signs: 50 + ((-4) * 6) >> 16 = 50 + 0xffffffff = 49
  TEST_RR_OP( 5,  pmhaccsu.h.b1, 0x00000031, 0xfffc0000, 0x00060000 );
  
  # Positive signed, positive unsigned: 200 + (100 * 100) >> 16 = 200 + 0 = 200
  TEST_RR_OP( 6,  pmhaccsu.h.b1, 0x000000c8, 0x00640000, 0x00640000 );
  
  # Zero multiply: 500 + (0 * 100) >> 16 = 500
  TEST_RR_OP( 7,  pmhaccsu.h.b1, 0x000001f4, 0x00000000, 0x00640000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

