# See LICENSE for license details.

#*****************************************************************************
# psas_wx.S
#-----------------------------------------------------------------------------
#
# Test psas.wx instruction (packed saturating add-sub cross word).
# Operates on 64-bit register: rd = (SAT(rs1_hi + rs2_lo), SAT(rs1_lo - rs2_hi))
# 2 elements of 32-bits each with cross operands and saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross add-sub: (0x00000005 + 0x00000003, 0x00000003 - 0x00000005) = (0x00000008, 0xfffffffe)
  TEST_RR_OP( 2, psas.wx, 0x00000008fffffffe, 0x0000000500000003, 0x0000000300000005 )

  # Zero case: (0x00000000 + 0x00000000, 0x00000000 - 0x00000000) = (0x00000000, 0x00000000)
  TEST_RR_OP( 3, psas.wx, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Saturation at max positive add: (1000000000 + 1000000000) saturates to 2147483647
  TEST_RR_OP( 4, psas.wx, 0x7fffffff7fffffff, 0x3b9ac9203b9ac920, 0xc46536dfc4653680 )

  # Saturation at min negative subtract: (1000000000 - (-1000000000)) saturates to 2147483647
  TEST_RR_OP( 5, psas.wx, 0x7fffffff7fffffff, 0x3b9ac9203b9ac920, 0xc46536dfc4653680 )

  # Mixed values: (100000 + 200000, 200000 - 100000) = (300000, 100000)
  TEST_RR_OP( 6, psas.wx, 0x00049680000186a0, 0x000186a0000186a0, 0x0003086000030860 )

  # Negative operands: (-100000 + -200000, -200000 - (-100000)) = (-300000, -100000)
  TEST_RR_OP( 7, psas.wx, 0xfffb6980fffb69800, 0xfffb69800fffb6980, 0xfff85ee0fff85ee0 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

