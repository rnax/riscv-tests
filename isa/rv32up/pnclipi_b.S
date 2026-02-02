# See LICENSE for license details.

#*****************************************************************************
# pnclipi_b.S
#-----------------------------------------------------------------------------
#
# Test pnclipi.b instruction (packed narrowing clip immediate byte signed).
# Clips 16-bit packed values to 8-bit signed range with immediate shift.
# Operates on 64-bit register pairs with 4 16-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0010 >> 0 clips to 0x10
  TEST_CASE_D32( 2, x10, x11, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclipi.b x8, x10, 0; \
  )

  # Right shift by 1: 0x0100 >> 1 = 0x0080 clips to 0x7f
  TEST_CASE_D32( 3, x10, x11, 0x7f7f7f7f, \
    li  x10, 0x01000100; \
    li  x11, 0x01000100; \
    pnclipi.b x8, x10, 1; \
  )

  # Right shift by 2: 0x0400 >> 2 = 0x0100 saturates to 0x7f
  TEST_CASE_D32( 4, x10, x11, 0x7f7f7f7f, \
    li  x10, 0x04000400; \
    li  x11, 0x04000400; \
    pnclipi.b x8, x10, 2; \
  )

  # Negative with shift: 0xff00 >> 1 = 0xff80 clips to 0x80
  TEST_CASE_D32( 5, x10, x11, 0x80808080, \
    li  x10, 0xff00ff00; \
    li  x11, 0xff00ff00; \
    pnclipi.b x8, x10, 1; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipi.b x8, x10, 0; \
  )

  # Right shift by 3: 0x0800 >> 3 = 0x0100 saturates to 0x7f
  TEST_CASE_D32( 7, x10, x11, 0x7f7f7f7f, \
    li  x10, 0x08000800; \
    li  x11, 0x08000800; \
    pnclipi.b x8, x10, 3; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

