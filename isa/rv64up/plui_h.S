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
  # Note: plui.h immediate range is -512 to 511
  # plui.h loads imm into upper bits of each halfword element
  #-------------------------------------------------------------

  # Load upper immediate 0x00
  TEST_CASE( 2, x14, 0x0000000000000000, \
    plui.h x14, 0x00; \
  )

  # Load upper immediate 0x42
  TEST_CASE( 3, x14, 0x4200420042004200, \
    plui.h x14, 0x42; \
  )

  # Load upper immediate -1 (0xff in upper bits)
  TEST_CASE( 4, x14, 0xff00ff00ff00ff00, \
    plui.h x14, -1; \
  )

  # Load upper immediate 127 (max representable in 8-bit upper)
  TEST_CASE( 5, x14, 0x7f007f007f007f00, \
    plui.h x14, 127; \
  )

  # Load upper immediate -128
  TEST_CASE( 6, x14, 0x8000800080008000, \
    plui.h x14, -128; \
  )

  # Load upper immediate 0x55
  TEST_CASE( 7, x14, 0x5500550055005500, \
    plui.h x14, 0x55; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

