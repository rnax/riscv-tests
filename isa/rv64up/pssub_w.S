# See LICENSE for license details.

#*****************************************************************************
# pssub_w.S
#-----------------------------------------------------------------------------
#
# Test pssub.w instruction (packed saturating signed subtract word).
# Operates on 64-bit register: rd = SAT(rs1 - rs2) for 2 words
# 2 elements of 32-bits each with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 500000 - 200000 = 300000 for each word
  TEST_RR_OP( 2, pssub.w, 0x00049680000496800, 0x0007a12000007a120, 0x0003086000030860 )

  # Saturation at max positive: 2000000000 - (-1000000000) = 3000000000 (saturates to 2147483647)
  TEST_RR_OP( 3, pssub.w, 0x7fffffff7fffffff, 0x77359400773594000, 0xc46536dfc4653680 )

  # Saturation at min negative: -2000000000 - 1000000000 = -3000000000 (saturates to -2147483648)
  TEST_RR_OP( 4, pssub.w, 0x8000000080000000, 0x8c4a6c008c4a6c00, 0x3b9ac9203b9ac920 )

  # Zero cases
  TEST_RR_OP( 5, pssub.w, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Negative result: 100000 - 500000 = -400000
  TEST_RR_OP( 6, pssub.w, 0xfff3cb00fff3cb00, 0x000186a0000186a0, 0x0007a12000007a120 )

  # Both negative: -100000 - (-500000) = 400000
  TEST_RR_OP( 7, pssub.w, 0x00061a8000061a80, 0xfffb69800fffb6980, 0xfff85ee0fff85ee0 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

