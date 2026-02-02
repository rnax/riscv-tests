# See LICENSE for license details.

#*****************************************************************************
# pnclipr_bs.S
#-----------------------------------------------------------------------------
#
# Test pnclipr.bs instruction (packed narrowing clip with rounding byte signed).
# Clips 16-bit packed values to 8-bit signed range with rounding.
# Operates on 64-bit register pairs with 4 16-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0010 rounds to 0x10
  TEST_CASE_D32( 2, x10, x11, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclipr.bs x8, x10; \
  )

  # Rounding: 0x0081 rounds to 0x81 (rounds up from 0x80)
  TEST_CASE_D32( 3, x10, x11, 0x81818181, \
    li  x10, 0x00810081; \
    li  x11, 0x00810081; \
    pnclipr.bs x8, x10; \
  )

  # Saturation at max positive: 0x0200 saturates to 0x7f
  TEST_CASE_D32( 4, x10, x11, 0x7f7f7f7f, \
    li  x10, 0x02000200; \
    li  x11, 0x02000200; \
    pnclipr.bs x8, x10; \
  )

  # Saturation at min negative: 0xff00 saturates to 0x80
  TEST_CASE_D32( 5, x10, x11, 0x80808080, \
    li  x10, 0xff00ff00; \
    li  x11, 0xff00ff00; \
    pnclipr.bs x8, x10; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipr.bs x8, x10; \
  )

  # Rounding down: 0x007f rounds to 0x7f
  TEST_CASE_D32( 7, x10, x11, 0x7f7f7f7f, \
    li  x10, 0x007f007f; \
    li  x11, 0x007f007f; \
    pnclipr.bs x8, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

