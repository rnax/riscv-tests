# See LICENSE for license details.

#*****************************************************************************
# pmhacc_h_b1.S
#-----------------------------------------------------------------------------
#
# Test pmhacc.h.b1 instruction (packed multiply high accumulate halfword top).
# Performs 16-bit signed multiply on upper halfwords and accumulates high 32-bit result.
# rd = rd + (sext(rs1[31:16]) * sext(rs2[31:16])) >> 16
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply-accumulate: 0 + (3 * 7) >> 16 = 0
  TEST_RR_OP( 2,  pmhacc.h.b1, 0x00000000, 0x00030000, 0x00070000 );
  
  # Accumulate to existing value: 100 + (5 * 10) >> 16 = 100
  TEST_RR_OP( 3,  pmhacc.h.b1, 0x00000064, 0x00050000, 0x000a0000 );
  
  # Larger multiply: 0x100 + (0x1000 * 0x1000) >> 16 = 0x100 + 0x100 = 0x200
  TEST_RR_OP( 4,  pmhacc.h.b1, 0x00000200, 0x10000000, 0x10000000 );
  
  # Negative multiply: 50 + ((-10) * 20) >> 16 = 50 + 0xffffffff = 49
  TEST_RR_OP( 5,  pmhacc.h.b1, 0x00000031, 0xfffb0000, 0x00140000 );
  
  # Both negative: 200 + ((-100) * (-100)) >> 16 = 200 + 0x271 = 0x471
  TEST_RR_OP( 6,  pmhacc.h.b1, 0x00000471, 0xff9c0000, 0xff9c0000 );
  
  # Zero multiply: 500 + (0 * 100) >> 16 = 500
  TEST_RR_OP( 7,  pmhacc.h.b1, 0x000001f4, 0x00000000, 0x00640000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

