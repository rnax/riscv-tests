# See LICENSE for license details.

#*****************************************************************************
# pli_b.S
#-----------------------------------------------------------------------------
#
# Test pli.b instruction (packed load immediate byte).
# Loads an 8-bit immediate into all 4 byte elements of a 32-bit register.
# rd = {imm, imm, imm, imm}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Load immediate 0x00
  TEST_CASE( 2, x14, 0x00000000, \
    pli.b x14, 0x00; \
  )

  # Load immediate 0x42
  TEST_CASE( 3, x14, 0x42424242, \
    pli.b x14, 0x42; \
  )

  # Load immediate 0xff
  TEST_CASE( 4, x14, 0xffffffff, \
    pli.b x14, 0xff; \
  )

  # Load immediate 0x7f (max positive)
  TEST_CASE( 5, x14, 0x7f7f7f7f, \
    pli.b x14, 0x7f; \
  )

  # Load immediate 0x80 (min negative)
  TEST_CASE( 6, x14, 0x80808080, \
    pli.b x14, 0x80; \
  )

  # Load immediate 0xaa
  TEST_CASE( 7, x14, 0xaaaaaaaa, \
    pli.b x14, 0xaa; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

