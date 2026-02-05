# See LICENSE for license details.

#*****************************************************************************
# psadd_b.S
#-----------------------------------------------------------------------------
#
# Test psadd.b instruction (packed saturating add bytes).
# Operates on 32-bit register: rd = SAT(rs1 + rs2) for 4 bytes
# 4 elements of 8-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 10 + 20 = 30 for each byte
  TEST_RR_OP( 2, psadd.b, 0x1e1e1e1e, 0x0a0a0a0a, 0x14141414 )

  # Saturation at max positive: 100 + 100 = 200 (saturates to 127)
  TEST_RR_OP( 3, psadd.b, 0x7f7f7f7f, 0x64646464, 0x64646464 )

  # Saturation at min negative: -100 + -100 = -200 (saturates to -128)
  TEST_RR_OP( 4, psadd.b, 0x80808080, 0x9c9c9c9c, 0x9c9c9c9c )

  # Zero cases
  TEST_RR_OP( 5, psadd.b, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed values: 50 + 30 = 80 for each byte
  TEST_RR_OP( 6, psadd.b, 0x50505050, 0x32323232, 0x1e1e1e1e )

  # Negative operands: -50 + -30 = -80 for each byte
  TEST_RR_OP( 7, psadd.b, 0xb0b0b0b0, 0xcecececece, 0xe2e2e2e2 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

