# See LICENSE for license details.

#*****************************************************************************
# pnclipri_b.S
#-----------------------------------------------------------------------------
#
# Test pnclipri.b instruction.
# Packed narrowing clip with immediate shift.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic: clip with shift 0
  TEST_CASE( 2, x14, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclipri.b x14, x10, 0; \
  )

  # Shift by 1
  TEST_CASE( 3, x14, 0x08080808, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclipri.b x14, x10, 1; \
  )

  # Zero input
  TEST_CASE( 4, x14, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipri.b x14, x10, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
