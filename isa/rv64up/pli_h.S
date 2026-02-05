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
  # Note: pli.h immediate range is -512 to 511
  #-------------------------------------------------------------

  # Load immediate 0x0000
  TEST_CASE( 2, x14, 0x0000000000000000, \
    pli.h x14, 0x00; \
  )

  # Load immediate 0x42 (positive value)
  TEST_CASE( 3, x14, 0x0042004200420042, \
    pli.h x14, 0x42; \
  )

  # Load immediate -1 (0xffff sign-extended)
  TEST_CASE( 4, x14, 0xffffffffffffffff, \
    pli.h x14, -1; \
  )

  # Load immediate 511 (max positive in range)
  TEST_CASE( 5, x14, 0x01ff01ff01ff01ff, \
    pli.h x14, 511; \
  )

  # Load immediate -512 (min negative in range)
  TEST_CASE( 6, x14, 0xfe00fe00fe00fe00, \
    pli.h x14, -512; \
  )

  # Load immediate -86 (0xffaa sign-extended)
  TEST_CASE( 7, x14, 0xffaaffaaffaaffaa, \
    pli.h x14, -86; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

