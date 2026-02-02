# See LICENSE for license details.

#*****************************************************************************
# mqacc_h00.S
#-----------------------------------------------------------------------------
#
# Test mqacc_h00 instruction (Q-format multiply-accumulate halfword 00).
# rd = rd + ((rs1[15:0] * rs2[15:0]) >> 15)
# Q15 fixed-point multiply with accumulation (lower halfwords)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply: 0.5 * 0.5 = 0.25
  # 0x4000 (Q15: 0.5) * 0x4000 (Q15: 0.5) >> 15 = 0x2000 (Q15: 0.25)
  # Accumulate: 0 + 0x2000 = 0x2000
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0x00002000, 0x00000000, 0x40004000, 0x40004000, x1, 0, x6 );
  
  # Accumulate to existing value: 0x1000 + (0x4000 * 0x4000 >> 15) = 0x3000
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0x00003000, 0x00001000, 0x40004000, 0x40004000, x1, 0, x6 );
  
  # Negative Q-format: -0.5 * 0.5 = -0.25
  # 0xC000 (Q15: -0.5) * 0x4000 (Q15: 0.5) >> 15 = 0xE000 (Q15: -0.25)
  # Accumulate: 0 + 0xE000 = 0xFFFFE000
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0xFFFFE000, 0x00000000, 0xC000C000, 0x40004000, x1, 0, x6 );
  
  # Both negative: -0.5 * -0.5 = 0.25
  # 0xC000 * 0xC000 >> 15 = 0x2000
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0x00002000, 0x00000000, 0xC000C000, 0xC000C000, x1, 0, x6 );
  
  # Small values: 0.1 * 0.1 ≈ 0.01
  # 0x0CCD (Q15: ~0.1) * 0x0CCD >> 15 ≈ 0x0106 (Q15: ~0.01)
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0x00000106, 0x00000000, 0x0CCD0CCD, 0x0CCD0CCD, x1, 0, x6 );
  
  # Zero multiply: 0 * 0.5 = 0
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0x00000000, 0x00000000, 0x00000000, 0x40004000, x1, 0, x6 );
  
  # One (Q15: 0x7FFF) * 0.5 = 0.5
  # 0x7FFF * 0x4000 >> 15 = 0x3FFF
  TEST_RR_OP( mqacc_h00, x2, x3, x4, 0x00003FFF, 0x00000000, 0x7FFF7FFF, 0x40004000, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

