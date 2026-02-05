# See LICENSE for license details.

#*****************************************************************************
# pli_db.S
#-----------------------------------------------------------------------------
#
# Test pli.db instruction (packed load immediate double-byte).
# Loads an 8-bit immediate into all 8 byte elements of a 64-bit register pair.
# rd:rd+1 = {imm, imm, imm, imm, imm, imm, imm, imm}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Load immediate 0x00
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    pli.db x14, 0x00; \
  )

  # Load immediate 0x42
  TEST_CASE_D32( 3, x14, x15, 0x4242424242424242, \
    pli.db x14, 0x42; \
  )

  # Load immediate -1 (0xff pattern)
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    pli.db x14, -1; \
  )

  # Load immediate 0x7f (max positive)
  TEST_CASE_D32( 5, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    pli.db x14, 0x7f; \
  )

  # Load immediate -128 (0x80 pattern)
  TEST_CASE_D32( 6, x14, x15, 0x8080808080808080, \
    pli.db x14, -128; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

