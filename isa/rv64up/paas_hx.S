# See LICENSE for license details.

#*****************************************************************************
# paas_hx.S
#-----------------------------------------------------------------------------
#
# Test paas.hx instruction (packed add-sub cross halfword).
# Operates on 32-bit register: rd = (rs1_hi + rs2_lo, rs1_lo - rs2_hi)
# 2 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross: (0x0005 + 0x0003, 0x0003 - 0x0005) = (0x0008, 0xfffe)
  TEST_RR_OP( 2, paas.hx, 0xfffeffffe, 0x00050003, 0x00050003 )

  # Zero case: (0x0000 + 0x0000, 0x0000 - 0x0000) = (0x0000, 0x0000)
  TEST_RR_OP( 3, paas.hx, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Positive add, negative sub: (0x0100 + 0x0050, 0x0050 - 0x0100) = (0x0150, 0xffb0)
  TEST_RR_OP( 4, paas.hx, 0xffb00150, 0x01000050, 0x01000050 )

  # Large values: (0x7fff + 0x0001, 0x0001 - 0x7fff) = (0x8000, 0x8002)
  TEST_RR_OP( 5, paas.hx, 0x80028000, 0x7fff0001, 0x7fff0001 )

  # Negative values: (0xff00 + 0xff00, 0xff00 - 0xff00) = (0xfe00, 0x0000)
  TEST_RR_OP( 6, paas.hx, 0x0000fe00, 0xff00ff00, 0xff00ff00 )

  # Different operands: (0x1234 + 0x5678, 0x9abc - 0xdef0) = (0x68ac, 0xbbcc)
  TEST_RR_OP( 7, paas.hx, 0xbbcc68ac, 0x12349abc, 0x5678def0 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

