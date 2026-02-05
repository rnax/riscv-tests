# See LICENSE for license details.

#*****************************************************************************
# psadd_w.S
#-----------------------------------------------------------------------------
#
# Test psadd.w instruction (packed saturating signed add word).
# Operates on 64-bit register: rd = SAT(rs1 + rs2) for 2 words
# 2 elements of 32-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100000 + 200000 = 300000 for each word
  TEST_RR_OP( 2, psadd.w, 0x00049680000496800, 0x000186a0000186a0, 0x0003086000030860 )

  # Saturation at max positive: 1000000000 + 1000000000 = 2000000000 (saturates to 2147483647)
  TEST_RR_OP( 3, psadd.w, 0x7fffffff7fffffff, 0x3b9ac9203b9ac920, 0x3b9ac9203b9ac920 )

  # Saturation at min negative: -1000000000 + -1000000000 = -2000000000 (saturates to -2147483648)
  TEST_RR_OP( 4, psadd.w, 0x8000000080000000, 0xc46536dfc4653680, 0xc46536dfc4653680 )

  # Zero cases
  TEST_RR_OP( 5, psadd.w, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed values: 500000 + 300000 = 800000
  TEST_RR_OP( 6, psadd.w, 0x000c35000000c3500, 0x0007a12000007a120, 0x00049680000496800 )

  # Negative operands: -500000 + -300000 = -800000
  TEST_RR_OP( 7, psadd.w, 0xfff3cb00fff3cb00, 0xfff85ee0fff85ee0, 0xfffb69800fffb6980 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

