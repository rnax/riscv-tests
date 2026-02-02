# See LICENSE for license details.

#*****************************************************************************
# pnclip_bs.S
#-----------------------------------------------------------------------------
#
# Test pnclip.bs instruction (packed narrowing clip byte signed).
# Clips 16-bit packed values to 8-bit signed range [-128, 127].
# Operates on 64-bit register pairs with 4 16-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0010 clips to 0x10 (16 fits in signed byte)
  TEST_CASE_D32( 2, x10, x11, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclip.bs x8, x10; \
  )

  # Saturation at max positive: 0x0200 saturates to 0x7f (127)
  TEST_CASE_D32( 3, x10, x11, 0x7f7f7f7f, \
    li  x10, 0x02000200; \
    li  x11, 0x02000200; \
    pnclip.bs x8, x10; \
  )

  # Saturation at min negative: 0xff00 saturates to 0x80 (-128)
  TEST_CASE_D32( 4, x10, x11, 0x80808080, \
    li  x10, 0xff00ff00; \
    li  x11, 0xff00ff00; \
    pnclip.bs x8, x10; \
  )

  # Mixed values: 0x0050 clips to 0x50, 0xff00 clips to 0x80
  TEST_CASE_D32( 5, x10, x11, 0x50508080, \
    li  x10, 0x00500050; \
    li  x11, 0xff00ff00; \
    pnclip.bs x8, x10; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclip.bs x8, x10; \
  )

  # Negative values: 0xff80 clips to 0x80 (-128)
  TEST_CASE_D32( 7, x10, x11, 0x80808080, \
    li  x10, 0xff80ff80; \
    li  x11, 0xff80ff80; \
    pnclip.bs x8, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

