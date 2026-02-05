# See LICENSE for license details.

#*****************************************************************************
# pli_w.S
#-----------------------------------------------------------------------------
#
# Test pli.w instruction (packed load immediate word).
# Loads a 32-bit immediate into both word elements of a 64-bit register.
# rd = {imm, imm}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # Note: pli.w immediate range is -512 to 511
  #-------------------------------------------------------------

  # Load immediate 0x00
  TEST_CASE( 2, x14, 0x0000000000000000, \
    pli.w x14, 0x00; \
  )

  # Load immediate 0x42 (positive value)
  TEST_CASE( 3, x14, 0x0000004200000042, \
    pli.w x14, 0x42; \
  )

  # Load immediate -1 (sign-extended to 0xffffffff)
  TEST_CASE( 4, x14, 0xffffffffffffffff, \
    pli.w x14, -1; \
  )

  # Load immediate 511 (max positive in range)
  TEST_CASE( 5, x14, 0x000001ff000001ff, \
    pli.w x14, 511; \
  )

  # Load immediate -512 (min negative in range)
  TEST_CASE( 6, x14, 0xfffffe00fffffe00, \
    pli.w x14, -512; \
  )

  # Load immediate -86
  TEST_CASE( 7, x14, 0xffffffaaffffffaa, \
    pli.w x14, -86; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

