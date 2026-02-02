# See LICENSE for license details.

#*****************************************************************************
# mqracc_h01.S
#-----------------------------------------------------------------------------
#
# Test mqracc_h01 instruction (Q-format multiply-accumulate with rounding halfword 01).
# rd = rd + ((rs1[15:0] * rs2[31:16] + 0x4000) >> 15)
# Q15 fixed-point multiply with rounding and accumulation (lower RS1 with upper RS2)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply with rounding: 0.5 * 0.5 = 0.25
  # RS1[15:0] = 0x4000, RS2[31:16] = 0x4000
  # 0x4000 * 0x4000 = 0x10000000, + 0x4000 = 0x10004000 >> 15 = 0x2000
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0x00002000, 0x00000000, 0x00004000, 0x40000000, x1, 0, x6 );
  
  # Accumulate to existing value: 0x1000 + rounded result = 0x3000
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0x00003000, 0x00001000, 0x00004000, 0x40000000, x1, 0, x6 );
  
  # Negative Q-format: -0.5 * 0.5 = -0.25
  # RS1[15:0] = 0xC000, RS2[31:16] = 0x4000
  # 0xC000 * 0x4000 = 0xFFFE0000, + 0x4000 = 0xFFFE4000 >> 15 = 0xFFFFC000
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0xFFFFC000, 0x00000000, 0x0000C000, 0x40000000, x1, 0, x6 );
  
  # Both negative: -0.5 * -0.5 = 0.25
  # RS1[15:0] = 0xC000, RS2[31:16] = 0xC000
  # 0xC000 * 0xC000 = 0x10000000, + 0x4000 = 0x10004000 >> 15 = 0x2000
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0x00002000, 0x00000000, 0x0000C000, 0xC0000000, x1, 0, x6 );
  
  # Small values with rounding: 0.1 * 0.1 ≈ 0.01
  # RS1[15:0] = 0x0CCD, RS2[31:16] = 0x0CCD
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0x00000215, 0x00000000, 0x00000CCD, 0x0CCD0000, x1, 0, x6 );
  
  # Zero multiply: 0 * 0.5 = 0
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0x00000000, 0x00000000, 0x00000000, 0x40000000, x1, 0, x6 );
  
  # One (Q15: 0x7FFF) * 0.5 = 0.5
  # RS1[15:0] = 0x7FFF, RS2[31:16] = 0x4000
  # 0x7FFF * 0x4000 = 0x1FFFC000, + 0x4000 = 0x20000000 >> 15 = 0x4000
  TEST_RR_OP( mqracc_h01, x2, x3, x4, 0x00004000, 0x00000000, 0x00007FFF, 0x40000000, x1, 0, x6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

