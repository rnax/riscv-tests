# See LICENSE for license details.

#*****************************************************************************
# plui_w.S
#-----------------------------------------------------------------------------
#
# Test plui.w instruction (packed load upper immediate word).
# Loads a 32-bit immediate into the upper 32 bits of both word elements.
# rd = {imm << 16, imm << 16}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # Note: plui.w immediate range is -512 to 511
  # plui.w loads imm << 16 into each word element
  #-------------------------------------------------------------

  # Load upper immediate 0x00
  TEST_CASE( 2, x14, 0x0000000000000000, \
    plui.w x14, 0x00; \
  )

  # Load upper immediate 0x42
  TEST_CASE( 3, x14, 0x0042000000420000, \
    plui.w x14, 0x42; \
  )

  # Load upper immediate -1 (0xffff0000 in each word)
  TEST_CASE( 4, x14, 0xffff0000ffff0000, \
    plui.w x14, -1; \
  )

  # Load upper immediate 511 (max positive in range)
  TEST_CASE( 5, x14, 0x01ff000001ff0000, \
    plui.w x14, 511; \
  )

  # Load upper immediate -512 (min negative in range)
  TEST_CASE( 6, x14, 0xfe000000fe000000, \
    plui.w x14, -512; \
  )

  # Load upper immediate 0x55
  TEST_CASE( 7, x14, 0x0055000000550000, \
    plui.w x14, 0x55; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

