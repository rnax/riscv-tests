# See LICENSE for license details.

#*****************************************************************************
# pssubu_h.S
#-----------------------------------------------------------------------------
#
# Test pssubu.h instruction (packed unsigned saturating subtract halfwords).
# Operates on 32-bit register: rd = SAT_U(rs1 - rs2) for 2 halfwords
# 2 elements of 16-bits each with unsigned saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 500 - 200 = 300 for each halfword
  TEST_RR_OP( 2, pssubu.h, 0x012c012c, 0x01f401f4, 0x00c800c8 )

  # Saturation at min unsigned: 200 - 500 = -300 (saturates to 0)
  TEST_RR_OP( 3, pssubu.h, 0x0000000000000000, 0x00c800c8, 0x01f401f4 )

  # Saturation at min: 0 - 1 = -1 (saturates to 0)
  TEST_RR_OP( 4, pssubu.h, 0x0000000000000000, 0x00000000, 0x00010001 )

  # Zero cases: 0 - 0 = 0
  TEST_RR_OP( 5, pssubu.h, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Large values: 40000 - 20000 = 20000 for each halfword
  TEST_RR_OP( 6, pssubu.h, 0x4e204e20, 0x9c409c40, 0x4e204e20 )

  # Same values: 1000 - 1000 = 0 for each halfword
  TEST_RR_OP( 7, pssubu.h, 0x0000000000000000, 0x03e803e8, 0x03e803e8 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

