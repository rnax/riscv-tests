# See LICENSE for license details.

#*****************************************************************************
# psas_hx.S
#-----------------------------------------------------------------------------
#
# Test psas.hx instruction (packed saturating add-sub cross halfword).
# Operates on 32-bit register: rd = (SAT(rs1_hi + rs2_lo), SAT(rs1_lo - rs2_hi))
# 2 elements of 16-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross: (0x0005 + 0x0003, 0x0003 - 0x0005) = (0x0008, 0xfffe)
  TEST_RR_OP( 2, psas.hx, 0xfffeffffe, 0x00050003, 0x00050003 )

  # Saturation on add: (0x7fff + 0x0001, 0x0001 - 0x7fff) = (0x7fff, 0x8002)
  TEST_RR_OP( 3, psas.hx, 0x80027fff, 0x7fff0001, 0x7fff0001 )

  # Saturation on sub: (0x0001 + 0x7fff, 0x7fff - 0x0001) = (0x8000, 0x7ffe)
  TEST_RR_OP( 4, psas.hx, 0x7ffe8000, 0x00017fff, 0x7fff0001 )

  # Negative saturation: (0x8000 + 0xffff, 0xffff - 0x8000) = (0x8000, 0x7fff)
  TEST_RR_OP( 5, psas.hx, 0x7fff8000, 0x8000ffff, 0xffff8000 )

  # Zero case: (0x0000 + 0x0000, 0x0000 - 0x0000) = (0x0000, 0x0000)
  TEST_RR_OP( 6, psas.hx, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed saturation: (0x7000 + 0x1000, 0x1000 - 0x7000) = (0x7fff, 0x9000)
  TEST_RR_OP( 7, psas.hx, 0x90007fff, 0x70001000, 0x10007000 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

