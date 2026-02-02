# See LICENSE for license details.

#*****************************************************************************
# pnclipr_hs.S
#-----------------------------------------------------------------------------
#
# Test pnclipr.hs instruction (packed narrowing clip with rounding halfword signed).
# Clips 32-bit packed values to 16-bit signed range with rounding.
# Operates on 64-bit register pairs with 2 32-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x00001000 rounds to 0x1000
  TEST_CASE_D32( 2, x10, x11, 0x10001000, \
    li  x10, 0x00001000; \
    li  x11, 0x00001000; \
    pnclipr.hs x8, x10; \
  )

  # Rounding: 0x00008001 rounds to 0x8001 (rounds up from 0x8000)
  TEST_CASE_D32( 3, x10, x11, 0x80018001, \
    li  x10, 0x00008001; \
    li  x11, 0x00008001; \
    pnclipr.hs x8, x10; \
  )

  # Saturation at max positive: 0x00020000 saturates to 0x7fff
  TEST_CASE_D32( 4, x10, x11, 0x7fff7fff, \
    li  x10, 0x00020000; \
    li  x11, 0x00020000; \
    pnclipr.hs x8, x10; \
  )

  # Saturation at min negative: 0xffff0000 saturates to 0x8000
  TEST_CASE_D32( 5, x10, x11, 0x80008000, \
    li  x10, 0xffff0000; \
    li  x11, 0xffff0000; \
    pnclipr.hs x8, x10; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipr.hs x8, x10; \
  )

  # Rounding down: 0x00007fff rounds to 0x7fff
  TEST_CASE_D32( 7, x10, x11, 0x7fff7fff, \
    li  x10, 0x00007fff; \
    li  x11, 0x00007fff; \
    pnclipr.hs x8, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

