# See LICENSE for license details.

#*****************************************************************************
# psaddu_b.S
#-----------------------------------------------------------------------------
#
# Test psaddu.b instruction (packed unsigned saturating add bytes).
# Operates on 32-bit register: rd = SAT_U(rs1 + rs2) for 4 bytes
# 4 elements of 8-bits each with unsigned saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 10 + 20 = 30 for each byte
  TEST_RR_OP( 2, psaddu.b, 0x1e1e1e1e, 0x0a0a0a0a, 0x14141414 )

  # Saturation at max unsigned: 200 + 100 = 300 (saturates to 255)
  TEST_RR_OP( 3, psaddu.b, 0xffffffff, 0xc8c8c8c8, 0x64646464 )

  # Saturation at max: 255 + 1 = 256 (saturates to 255)
  TEST_RR_OP( 4, psaddu.b, 0xffffffff, 0xffffffff, 0x01010101 )

  # Zero cases
  TEST_RR_OP( 5, psaddu.b, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed values: 100 + 50 = 150 for each byte
  TEST_RR_OP( 6, psaddu.b, 0x96969696, 0x64646464, 0x32323232 )

  # Large values: 200 + 200 = 400 (saturates to 255)
  TEST_RR_OP( 7, psaddu.b, 0xffffffff, 0xc8c8c8c8, 0xc8c8c8c8 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

