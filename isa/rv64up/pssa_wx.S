# See LICENSE for license details.

#*****************************************************************************
# pssa_wx.S
#-----------------------------------------------------------------------------
#
# Test pssa.wx instruction (packed saturating sub-add cross word).
# Operates on 64-bit register: rd = (SAT(rs1_hi - rs2_lo), SAT(rs1_lo + rs2_hi))
# 2 elements of 32-bits each with cross operands and saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross sub-add: (0x00000005 - 0x00000003, 0x00000003 + 0x00000005) = (0x00000002, 0x00000008)
  TEST_RR_OP( 2, pssa.wx, 0x0000000800000002, 0x0000000500000003, 0x0000000300000005 )

  # Zero case: (0x00000000 - 0x00000000, 0x00000000 + 0x00000000) = (0x00000000, 0x00000000)
  TEST_RR_OP( 3, pssa.wx, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Saturation at max positive add: (1000000000 - (-1000000000), 1000000000 + 1000000000) saturates to (2147483647, 2147483647)
  TEST_RR_OP( 4, pssa.wx, 0x7fffffff7fffffff, 0x3b9ac9203b9ac920, 0xc46536dfc4653680 )

  # Saturation at min negative subtract: (-1000000000 - 1000000000, -1000000000 + (-1000000000)) saturates to (-2147483648, -2147483648)
  TEST_RR_OP( 5, pssa.wx, 0x8000000080000000, 0xc46536dfc4653680, 0x3b9ac9203b9ac920 )

  # Mixed values: (500000 - 200000, 200000 + 100000) = (300000, 300000)
  TEST_RR_OP( 6, pssa.wx, 0x00049680000496800, 0x0007a12000007a120, 0x0003086000030860 )

  # Negative operands: (-500000 - (-200000), -200000 + (-100000)) = (-300000, -300000)
  TEST_RR_OP( 7, pssa.wx, 0xfffb69800fffb6980, 0xfff85ee0fff85ee0, 0xfffb69800fffb6980 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

