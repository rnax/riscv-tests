# See LICENSE for license details.

#*****************************************************************************
# pssub_h.S
#-----------------------------------------------------------------------------
#
# Test pssub.h instruction (packed saturating subtract halfwords).
# Operates on 32-bit register: rd = SAT(rs1 - rs2) for 2 halfwords
# 2 elements of 16-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 500 - 200 = 300 for each halfword
  TEST_RR_OP( 2, pssub.h, 0x012c012c, 0x01f401f4, 0x00c800c8 )

  # Saturation at max positive: 20000 - (-20000) = 40000 (saturates to 32767)
  TEST_RR_OP( 3, pssub.h, 0x7fff7fff, 0x4e204e20, 0xb1e0b1e0 )

  # Saturation at min negative: -20000 - 20000 = -40000 (saturates to -32768)
  TEST_RR_OP( 4, pssub.h, 0x8000800080008000, 0xb1e0b1e0, 0x4e204e20 )

  # Zero cases: 0 - 0 = 0
  TEST_RR_OP( 5, pssub.h, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Negative result: 200 - 500 = -300
  TEST_RR_OP( 6, pssub.h, 0xfed4fed4, 0x00c800c8, 0x01f401f4 )

  # Same values: 1000 - 1000 = 0 for each halfword
  TEST_RR_OP( 7, pssub.h, 0x0000000000000000, 0x03e803e8, 0x03e803e8 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

