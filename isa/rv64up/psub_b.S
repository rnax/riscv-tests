# See LICENSE for license details.

#*****************************************************************************
# psub_b.S
#-----------------------------------------------------------------------------
#
# Test psub.b instruction (packed subtract bytes).
# Operates on 32-bit register: rd = rs1 - rs2 for 4 bytes
# 4 elements of 8-bits each with wrapping subtract
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 50 - 20 = 30 for each byte
  TEST_RR_OP( 2, psub.b, 0x1e1e1e1e, 0x32323232, 0x14141414 )

  # Wrapping subtract: 20 - 50 = -30 (wraps in 8-bit)
  TEST_RR_OP( 3, psub.b, 0xe2e2e2e2, 0x14141414, 0x32323232 )

  # Zero cases: 0 - 0 = 0
  TEST_RR_OP( 4, psub.b, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Large values: 255 - 1 = 254 for each byte
  TEST_RR_OP( 5, psub.b, 0xfefefefe, 0xffffffff, 0x01010101 )

  # Same values: 100 - 100 = 0 for each byte
  TEST_RR_OP( 6, psub.b, 0x0000000000000000, 0x64646464, 0x64646464 )

  # Negative operands: -50 - (-20) = -30 for each byte
  TEST_RR_OP( 7, psub.b, 0xe2e2e2e2, 0xcecececece, 0xececececec )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

