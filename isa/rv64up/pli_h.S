# See LICENSE for license details.

#*****************************************************************************
# pli_h.S
#-----------------------------------------------------------------------------
#
# Test pli.h instruction (packed load immediate halfword).
# Loads a 16-bit immediate into both halfword elements of a 32-bit register.
# rd = {imm, imm}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Load immediate 0x0000
  TEST_CASE( 2, x14, 0x00000000, \
    pli.h x14, 0x0000; \
  )

  # Load immediate 0x1234
  TEST_CASE( 3, x14, 0x12341234, \
    pli.h x14, 0x1234; \
  )

  # Load immediate 0xffff
  TEST_CASE( 4, x14, 0xffffffff, \
    pli.h x14, 0xffff; \
  )

  # Load immediate 0x7fff (max positive)
  TEST_CASE( 5, x14, 0x7fff7fff, \
    pli.h x14, 0x7fff; \
  )

  # Load immediate 0x8000 (min negative)
  TEST_CASE( 6, x14, 0x80008000, \
    pli.h x14, 0x8000; \
  )

  # Load immediate 0xaaaa
  TEST_CASE( 7, x14, 0xaaaaaaaa, \
    pli.h x14, 0xaaaa; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

