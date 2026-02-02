# See LICENSE for license details.

#*****************************************************************************
# pnclipiu_h.S
#-----------------------------------------------------------------------------
#
# Test pnclipiu.h instruction (packed narrowing clip immediate unsigned halfword).
# Clips 32-bit packed values to 16-bit unsigned range [0, 65535] with immediate shift.
# Operates on 64-bit register pairs with 2 32-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x00001000 >> 0 clips to 0x1000
  TEST_CASE_D32( 2, x10, x11, 0x10001000, \
    li  x10, 0x00001000; \
    li  x11, 0x00001000; \
    pnclipiu.h x8, x10, 0; \
  )

  # Right shift by 1: 0x00010000 >> 1 = 0x00008000 clips to 0x8000
  TEST_CASE_D32( 3, x10, x11, 0x80008000, \
    li  x10, 0x00010000; \
    li  x11, 0x00010000; \
    pnclipiu.h x8, x10, 1; \
  )

  # Saturation at max: 0x00020000 >> 0 saturates to 0xffff
  TEST_CASE_D32( 4, x10, x11, 0xffffffff, \
    li  x10, 0x00020000; \
    li  x11, 0x00020000; \
    pnclipiu.h x8, x10, 0; \
  )

  # Negative clipped to 0: 0xffff0000 >> 0 clips to 0x0000
  TEST_CASE_D32( 5, x10, x11, 0x00000000, \
    li  x10, 0xffff0000; \
    li  x11, 0xffff0000; \
    pnclipiu.h x8, x10, 0; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipiu.h x8, x10, 0; \
  )

  # Right shift by 2: 0x00040000 >> 2 = 0x00010000 saturates to 0xffff
  TEST_CASE_D32( 7, x10, x11, 0xffffffff, \
    li  x10, 0x00040000; \
    li  x11, 0x00040000; \
    pnclipiu.h x8, x10, 2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

