# See LICENSE for license details.

#*****************************************************************************
# pnclipri_h.S
#-----------------------------------------------------------------------------
#
# Test pnclipri.h instruction (packed narrowing clip with rounding immediate halfword signed).
# Clips 32-bit packed values to 16-bit signed range with rounding and immediate shift.
# Operates on 64-bit register pairs with 2 32-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x00001000 >> 0 rounds to 0x1000
  TEST_CASE_D32( 2, x10, x11, 0x10001000, \
    li  x10, 0x00001000; \
    li  x11, 0x00001000; \
    pnclipri.h x8, x10, 0; \
  )

  # Right shift by 1 with rounding: 0x00010000 >> 1 = 0x00008000 rounds to 0x8000
  TEST_CASE_D32( 3, x10, x11, 0x80008000, \
    li  x10, 0x00010000; \
    li  x11, 0x00010000; \
    pnclipri.h x8, x10, 1; \
  )

  # Right shift by 2 with rounding: 0x00020000 >> 2 = 0x00008000 rounds to 0x8000
  TEST_CASE_D32( 4, x10, x11, 0x80008000, \
    li  x10, 0x00020000; \
    li  x11, 0x00020000; \
    pnclipri.h x8, x10, 2; \
  )

  # Negative with shift and rounding: 0xffff0000 >> 1 = 0xffff8000 rounds to 0x8000
  TEST_CASE_D32( 5, x10, x11, 0x80008000, \
    li  x10, 0xffff0000; \
    li  x11, 0xffff0000; \
    pnclipri.h x8, x10, 1; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipri.h x8, x10, 0; \
  )

  # Right shift by 3 with rounding: 0x00040000 >> 3 = 0x00008000 rounds to 0x8000
  TEST_CASE_D32( 7, x10, x11, 0x80008000, \
    li  x10, 0x00040000; \
    li  x11, 0x00040000; \
    pnclipri.h x8, x10, 3; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

