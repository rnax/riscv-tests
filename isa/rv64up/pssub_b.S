# See LICENSE for license details.

#*****************************************************************************
# pssub_b.S
#-----------------------------------------------------------------------------
#
# Test pssub.b instruction (packed saturating subtract bytes).
# Operates on 32-bit register: rd = SAT(rs1 - rs2) for 4 bytes
# 4 elements of 8-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 50 - 20 = 30 for each byte
  TEST_RR_OP( 2, pssub.b, 0x1e1e1e1e, 0x32323232, 0x14141414 )

  # Saturation at max positive: 100 - (-100) = 200 (saturates to 127)
  TEST_RR_OP( 3, pssub.b, 0x7f7f7f7f, 0x64646464, 0x9c9c9c9c )

  # Saturation at min negative: -100 - 100 = -200 (saturates to -128)
  TEST_RR_OP( 4, pssub.b, 0x80808080, 0x9c9c9c9c, 0x64646464 )

  # Zero cases: 0 - 0 = 0
  TEST_RR_OP( 5, pssub.b, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Negative result: 20 - 50 = -30 for each byte
  TEST_RR_OP( 6, pssub.b, 0xe2e2e2e2, 0x14141414, 0x32323232 )

  # Same values: 100 - 100 = 0 for each byte
  TEST_RR_OP( 7, pssub.b, 0x0000000000000000, 0x64646464, 0x64646464 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

