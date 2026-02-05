# See LICENSE for license details.

#*****************************************************************************
# pssubu_w.S
#-----------------------------------------------------------------------------
#
# Test pssubu.w instruction (packed saturating unsigned subtract word).
# Operates on 64-bit register: rd = SAT(rs1 - rs2) for 2 words
# 2 elements of 32-bits each with unsigned saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 500000 - 200000 = 300000 for each word
  TEST_RR_OP( 2, pssubu.w, 0x00049680000496800, 0x0007a12000007a120, 0x0003086000030860 )

  # Saturation at zero: 100000 - 500000 = -400000 (saturates to 0)
  TEST_RR_OP( 3, pssubu.w, 0x0000000000000000, 0x000186a0000186a0, 0x0007a12000007a120 )

  # Zero cases
  TEST_RR_OP( 4, pssubu.w, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Large values: 3000000000 - 1000000000 = 2000000000
  TEST_RR_OP( 5, pssubu.w, 0x77359400773594000, 0xb2d05e00b2d05e00, 0x3b9ac9203b9ac920 )

  # Subtract from max: 4294967295 - 1 = 4294967294
  TEST_RR_OP( 6, pssubu.w, 0xfffffffefffffffe, 0xffffffff, 0x00000001 )

  # Subtract equal values: 1000000 - 1000000 = 0
  TEST_RR_OP( 7, pssubu.w, 0x0000000000000000, 0x000f424000000f4240, 0x000f424000000f4240 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

