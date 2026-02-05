# See LICENSE for license details.

#*****************************************************************************
# psadd_h.S
#-----------------------------------------------------------------------------
#
# Test psadd.h instruction (packed saturating add halfwords).
# Operates on 32-bit register: rd = SAT(rs1 + rs2) for 2 halfwords
# 2 elements of 16-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100 + 200 = 300 for each halfword
  TEST_RR_OP( 2, psadd.h, 0x012c012c, 0x00640064, 0x00c800c8 )

  # Saturation at max positive: 20000 + 20000 = 40000 (saturates to 32767)
  TEST_RR_OP( 3, psadd.h, 0x7fff7fff, 0x4e204e20, 0x4e204e20 )

  # Saturation at min negative: -20000 + -20000 = -40000 (saturates to -32768)
  TEST_RR_OP( 4, psadd.h, 0x8000800080008000, 0xb1e0b1e0, 0xb1e0b1e0 )

  # Zero cases
  TEST_RR_OP( 5, psadd.h, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed values: 1000 + 500 = 1500
  TEST_RR_OP( 6, psadd.h, 0x05dc05dc, 0x03e803e8, 0x01f401f4 )

  # Negative operands: -1000 + -500 = -1500
  TEST_RR_OP( 7, psadd.h, 0xfa24fa24, 0xfc18fc18, 0xfe0cfe0c )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

