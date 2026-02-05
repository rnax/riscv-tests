# See LICENSE for license details.

#*****************************************************************************
# psaddu_h.S
#-----------------------------------------------------------------------------
#
# Test psaddu.h instruction (packed unsigned saturating add halfwords).
# Operates on 32-bit register: rd = SAT_U(rs1 + rs2) for 2 halfwords
# 2 elements of 16-bits each with unsigned saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100 + 200 = 300 for each halfword
  TEST_RR_OP( 2, psaddu.h, 0x012c012c, 0x00640064, 0x00c800c8 )

  # Saturation at max unsigned: 40000 + 30000 = 70000 (saturates to 65535)
  TEST_RR_OP( 3, psaddu.h, 0xffffffff, 0x9c409c40, 0x75307530 )

  # Saturation at max: 65535 + 1 = 65536 (saturates to 65535)
  TEST_RR_OP( 4, psaddu.h, 0xffffffff, 0xffffffff, 0x00010001 )

  # Zero cases
  TEST_RR_OP( 5, psaddu.h, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Mixed values: 1000 + 500 = 1500
  TEST_RR_OP( 6, psaddu.h, 0x05dc05dc, 0x03e803e8, 0x01f401f4 )

  # Large values: 30000 + 30000 = 60000 (saturates to 65535)
  TEST_RR_OP( 7, psaddu.h, 0xffffffff, 0x75307530, 0x75307530 )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

