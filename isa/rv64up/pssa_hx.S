# See LICENSE for license details.

#*****************************************************************************
# pssa_hx.S
#-----------------------------------------------------------------------------
#
# Test pssa.hx instruction (packed saturating sub-add cross halfword).
# Operates on 32-bit register: rd = (SAT(rs1_hi - rs2_lo), SAT(rs1_lo + rs2_hi))
# 2 elements of 16-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross: (0x0005 - 0x0003, 0x0003 + 0x0005) = (0x0002, 0x0008)
  TEST_RR_OP( 2, pssa.hx, 0x00080002, 0x00050003, 0x00050003 )

  # Saturation on sub: (0x0001 - 0x7fff, 0x7fff + 0x0001) = (0x8000, 0x7fff)
  TEST_RR_OP( 3, pssa.hx, 0x7fff8000, 0x00017fff, 0x7fff0001 )

  # Saturation on add: (0x7fff - 0x0001, 0x0001 + 0x7fff) = (0x7ffe, 0x7fff)
  TEST_RR_OP( 4, pssa.hx, 0x7fff7ffe, 0x7fff0001, 0x7fff0001 )

  # Negative saturation: (0xffff - 0x8000, 0x8000 + 0xffff) = (0x7fff, 0x7fff)
  TEST_RR_OP( 5, pssa.hx, 0x7fff7fff, 0xffff8000, 0x8000ffff )

  # Zero case: (0x0000 - 0x0000, 0x0000 + 0x0000) = (0x0000, 0x0000)
  TEST_RR_OP( 6, pssa.hx, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed saturation: (0x1000 - 0x7000, 0x7000 + 0x1000) = (0x9000, 0x7fff)
  TEST_RR_OP( 7, pssa.hx, 0x7fff9000, 0x10007000, 0x70001000 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

