# See LICENSE for license details.

#*****************************************************************************
# psaddu_w.S
#-----------------------------------------------------------------------------
#
# Test psaddu.w instruction (packed saturating unsigned add word).
# Operates on 64-bit register: rd = SAT(rs1 + rs2) for 2 words
# 2 elements of 32-bits each with unsigned saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100000 + 200000 = 300000 for each word
  TEST_RR_OP( 2, psaddu.w, 0x00049680000496800, 0x000186a0000186a0, 0x0003086000030860 )

  # Saturation at max unsigned: 2000000000 + 2000000000 = 4000000000 (saturates to 4294967295)
  TEST_RR_OP( 3, psaddu.w, 0xffffffffffffffffff, 0x77359400773594000, 0x77359400773594000 )

  # Zero cases
  TEST_RR_OP( 4, psaddu.w, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Large values: 3000000000 + 1000000000 = 4000000000 (saturates to 4294967295)
  TEST_RR_OP( 5, psaddu.w, 0xffffffffffffffffff, 0xb2d05e00b2d05e00, 0x3b9ac9203b9ac920 )

  # Mixed values: 500000 + 300000 = 800000
  TEST_RR_OP( 6, psaddu.w, 0x000c35000000c3500, 0x0007a12000007a120, 0x00049680000496800 )

  # Max value + 1: 4294967295 + 1 = 4294967296 (saturates to 4294967295)
  TEST_RR_OP( 7, psaddu.w, 0xffffffffffffffffff, 0xffffffff, 0x00000001 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

