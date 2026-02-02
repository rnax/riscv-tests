# See LICENSE for license details.

#*****************************************************************************
# mqracc_h00.S
#-----------------------------------------------------------------------------
#
# Test mqracc_h00 instruction (Q-format multiply-accumulate with rounding halfword 00).
# rd = rd + ((rs1[15:0] * rs2[15:0] + 0x4000) >> 15)
# Q15 fixed-point multiply with rounding and accumulation (lower halfwords)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply with rounding: 0.5 * 0.5 = 0.25
  # 0x4000 * 0x4000 = 0x10000000, + 0x4000 = 0x10004000 >> 15 = 0x2000
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0x00002000, 0x00000000, 0x40004000, 0x40004000, x1, 0, x6 );
  
  # Accumulate to existing value: 0x1000 + rounded result = 0x3000
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0x00003000, 0x00001000, 0x40004000, 0x40004000, x1, 0, x6 );
  
  # Negative Q-format: -0.5 * 0.5 = -0.25
  # 0xC000 * 0x4000 = 0xFFFE0000, + 0x4000 = 0xFFFE4000 >> 15 = 0xFFFFC000 (sign-extended)
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0xFFFFC000, 0x00000000, 0xC000C000, 0x40004000, x1, 0, x6 );
  
  # Both negative: -0.5 * -0.5 = 0.25
  # 0xC000 * 0xC000 = 0x10000000, + 0x4000 = 0x10004000 >> 15 = 0x2000
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0x00002000, 0x00000000, 0xC000C000, 0xC000C000, x1, 0, x6 );
  
  # Small values with rounding: 0.1 * 0.1 ≈ 0.01
  # 0x0CCD * 0x0CCD = 0x010A5A09, + 0x4000 = 0x010A9A09 >> 15 = 0x0215
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0x00000215, 0x00000000, 0x0CCD0CCD, 0x0CCD0CCD, x1, 0, x6 );
  
  # Zero multiply: 0 * 0.5 = 0
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0x00000000, 0x00000000, 0x00000000, 0x40004000, x1, 0, x6 );
  
  # One (Q15: 0x7FFF) * 0.5 = 0.5
  # 0x7FFF * 0x4000 = 0x1FFFC000, + 0x4000 = 0x20000000 >> 15 = 0x4000
  TEST_RR_OP( mqracc_h00, x2, x3, x4, 0x00004000, 0x00000000, 0x7FFF7FFF, 0x40004000, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

