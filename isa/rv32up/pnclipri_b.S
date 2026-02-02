# See LICENSE for license details.

#*****************************************************************************
# pnclipri_b.S
#-----------------------------------------------------------------------------
#
# Test pnclipri.b instruction (packed narrowing clip with rounding immediate byte signed).
# Clips 16-bit packed values to 8-bit signed range with rounding and immediate shift.
# Operates on 64-bit register pairs with 4 16-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0010 >> 0 rounds to 0x10
  TEST_CASE_D32( 2, x10, x11, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclipri.b x8, x10, 0; \
  )

  # Right shift by 1 with rounding: 0x0100 >> 1 = 0x0080 rounds to 0x80
  TEST_CASE_D32( 3, x10, x11, 0x80808080, \
    li  x10, 0x01000100; \
    li  x11, 0x01000100; \
    pnclipri.b x8, x10, 1; \
  )

  # Right shift by 2 with rounding: 0x0200 >> 2 = 0x0080 rounds to 0x80
  TEST_CASE_D32( 4, x10, x11, 0x80808080, \
    li  x10, 0x02000200; \
    li  x11, 0x02000200; \
    pnclipri.b x8, x10, 2; \
  )

  # Negative with shift and rounding: 0xff00 >> 1 = 0xff80 rounds to 0x80
  TEST_CASE_D32( 5, x10, x11, 0x80808080, \
    li  x10, 0xff00ff00; \
    li  x11, 0xff00ff00; \
    pnclipri.b x8, x10, 1; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipri.b x8, x10, 0; \
  )

  # Right shift by 3 with rounding: 0x0400 >> 3 = 0x0080 rounds to 0x80
  TEST_CASE_D32( 7, x10, x11, 0x80808080, \
    li  x10, 0x04000400; \
    li  x11, 0x04000400; \
    pnclipri.b x8, x10, 3; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

