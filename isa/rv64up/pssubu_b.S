# See LICENSE for license details.

#*****************************************************************************
# pssubu_b.S
#-----------------------------------------------------------------------------
#
# Test pssubu.b instruction (packed unsigned saturating subtract bytes).
# Operates on 32-bit register: rd = SAT_U(rs1 - rs2) for 4 bytes
# 4 elements of 8-bits each with unsigned saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 50 - 20 = 30 for each byte
  TEST_RR_OP( 2, pssubu.b, 0x1e1e1e1e, 0x32323232, 0x14141414 )

  # Saturation at min unsigned: 20 - 50 = -30 (saturates to 0)
  TEST_RR_OP( 3, pssubu.b, 0x0000000000000000, 0x14141414, 0x32323232 )

  # Saturation at min: 0 - 1 = -1 (saturates to 0)
  TEST_RR_OP( 4, pssubu.b, 0x0000000000000000, 0x00000000, 0x01010101 )

  # Zero cases: 0 - 0 = 0
  TEST_RR_OP( 5, pssubu.b, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Large values: 200 - 100 = 100 for each byte
  TEST_RR_OP( 6, pssubu.b, 0x64646464, 0xc8c8c8c8, 0x64646464 )

  # Same values: 100 - 100 = 0 for each byte
  TEST_RR_OP( 7, pssubu.b, 0x0000000000000000, 0x64646464, 0x64646464 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

