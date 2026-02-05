# See LICENSE for license details.

#*****************************************************************************
# pli_dh.S
#-----------------------------------------------------------------------------
#
# Test pli.dh instruction (packed load immediate double-halfword).
# Loads a 16-bit immediate into all 4 halfword elements of a 64-bit register pair.
# rd:rd+1 = {imm, imm, imm, imm}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Load immediate 0
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    pli.dh x14, 0; \
  )

  # Load immediate 0x100
  TEST_CASE_D32( 3, x14, x15, 0x0100010001000100, \
    pli.dh x14, 0x100; \
  )

  # Load immediate -1 (0xffff pattern)
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    pli.dh x14, -1; \
  )

  # Load immediate 0x1ff (max positive in range)
  TEST_CASE_D32( 5, x14, x15, 0x01ff01ff01ff01ff, \
    pli.dh x14, 0x1ff; \
  )

  # Load immediate -512 (0xfe00 pattern)
  TEST_CASE_D32( 6, x14, x15, 0xfe00fe00fe00fe00, \
    pli.dh x14, -512; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

