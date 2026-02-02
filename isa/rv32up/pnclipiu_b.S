# See LICENSE for license details.

#*****************************************************************************
# pnclipiu_b.S
#-----------------------------------------------------------------------------
#
# Test pnclipiu.b instruction (packed narrowing clip immediate unsigned byte).
# Clips 16-bit packed values to 8-bit unsigned range [0, 255] with immediate shift.
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
    pnclipiu.b x8, x10, 0; \
  )

  # Right shift by 1: 0x0100 >> 1 = 0x0080 clips to 0x80
  TEST_CASE_D32( 3, x10, x11, 0x80808080, \
    li  x10, 0x01000100; \
    li  x11, 0x01000100; \
    pnclipiu.b x8, x10, 1; \
  )

  # Saturation at max: 0x0200 >> 0 saturates to 0xff
  TEST_CASE_D32( 4, x10, x11, 0xffffffff, \
    li  x10, 0x02000200; \
    li  x11, 0x02000200; \
    pnclipiu.b x8, x10, 0; \
  )

  # Negative clipped to 0: 0xff00 >> 0 clips to 0x00
  TEST_CASE_D32( 5, x10, x11, 0x00000000, \
    li  x10, 0xff00ff00; \
    li  x11, 0xff00ff00; \
    pnclipiu.b x8, x10, 0; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipiu.b x8, x10, 0; \
  )

  # Right shift by 2: 0x0400 >> 2 = 0x0100 saturates to 0xff
  TEST_CASE_D32( 7, x10, x11, 0xffffffff, \
    li  x10, 0x04000400; \
    li  x11, 0x04000400; \
    pnclipiu.b x8, x10, 2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

