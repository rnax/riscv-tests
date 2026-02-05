# See LICENSE for license details.

#*****************************************************************************
# plui_h.S
#-----------------------------------------------------------------------------
#
# Test plui.h instruction (packed load upper immediate halfword).
# Loads a 16-bit immediate into the upper halfword of both halfword elements.
# rd = {imm << 16, imm << 16}
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
    plui.h x14, 0x0000; \
  )

  # Load immediate 0x1234
  TEST_CASE( 3, x14, 0x12341234, \
    plui.h x14, 0x1234; \
  )

  # Load immediate 0xffff
  TEST_CASE( 4, x14, 0xffffffff, \
    plui.h x14, 0xffff; \
  )

  # Load immediate 0x7fff (max positive)
  TEST_CASE( 5, x14, 0x7fff7fff, \
    plui.h x14, 0x7fff; \
  )

  # Load immediate 0x8000 (min negative)
  TEST_CASE( 6, x14, 0x80008000, \
    plui.h x14, 0x8000; \
  )

  # Load immediate 0x5555
  TEST_CASE( 7, x14, 0x55555555, \
    plui.h x14, 0x5555; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

