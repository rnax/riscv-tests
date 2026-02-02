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

  # Load immediate 0x0000
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    pli.dh x14, 0x0000; \
  )

  # Load immediate 0x1234
  TEST_CASE_D32( 3, x14, x15, 0x1234123412341234, \
    pli.dh x14, 0x1234; \
  )

  # Load immediate 0xffff
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    pli.dh x14, 0xffff; \
  )

  # Load immediate 0x7fff (max positive)
  TEST_CASE_D32( 5, x14, x15, 0x7fff7fff7fff7fff, \
    pli.dh x14, 0x7fff; \
  )

  # Load immediate 0x8000 (min negative)
  TEST_CASE_D32( 6, x14, x15, 0x8000800080008000, \
    pli.dh x14, 0x8000; \
  )

  # Load immediate 0xaaaa
  TEST_CASE_D32( 7, x14, x15, 0xaaaaaaaaaaaaaaaa, \
    pli.dh x14, 0xaaaa; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

