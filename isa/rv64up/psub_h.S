# See LICENSE for license details.

#*****************************************************************************
# psub_h.S
#-----------------------------------------------------------------------------
#
# Test psub.h instruction (packed subtract halfwords).
# Operates on 32-bit register: rd = rs1 - rs2 for 2 halfwords
# 2 elements of 16-bits each with wrapping subtract
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic subtract: 500 - 200 = 300 for each halfword
  TEST_RR_OP( 2, psub.h, 0x012c012c, 0x01f401f4, 0x00c800c8 )

  # Wrapping subtract: 200 - 500 = -300 (wraps in 16-bit)
  TEST_RR_OP( 3, psub.h, 0xfed4fed4, 0x00c800c8, 0x01f401f4 )

  # Zero cases: 0 - 0 = 0
  TEST_RR_OP( 4, psub.h, 0x0000000000000000, 0x00000000, 0x00000000 )

  # Large values: 65535 - 1 = 65534 for each halfword
  TEST_RR_OP( 5, psub.h, 0xfffeffffe, 0xffffffff, 0x00010001 )

  # Same values: 1000 - 1000 = 0 for each halfword
  TEST_RR_OP( 6, psub.h, 0x0000000000000000, 0x03e803e8, 0x03e803e8 )

  # Negative operands: -1000 - (-500) = -500
  TEST_RR_OP( 7, psub.h, 0xfe0cfe0c, 0xfc18fc18, 0xfe0cfe0c )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

