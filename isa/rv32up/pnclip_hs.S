# See LICENSE for license details.

#*****************************************************************************
# pnclip_hs.S
#-----------------------------------------------------------------------------
#
# Test pnclip.hs instruction (packed narrowing clip halfword signed).
# Clips 32-bit packed values to 16-bit signed range [-32768, 32767].
# Operates on 64-bit register pairs with 2 32-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x00001000 clips to 0x1000 (4096 fits in signed halfword)
  TEST_CASE_D32( 2, x10, x11, 0x10001000, \
    li  x10, 0x00001000; \
    li  x11, 0x00001000; \
    pnclip.hs x8, x10; \
  )

  # Saturation at max positive: 0x00020000 saturates to 0x7fff (32767)
  TEST_CASE_D32( 3, x10, x11, 0x7fff7fff, \
    li  x10, 0x00020000; \
    li  x11, 0x00020000; \
    pnclip.hs x8, x10; \
  )

  # Saturation at min negative: 0xffff0000 saturates to 0x8000 (-32768)
  TEST_CASE_D32( 4, x10, x11, 0x80008000, \
    li  x10, 0xffff0000; \
    li  x11, 0xffff0000; \
    pnclip.hs x8, x10; \
  )

  # Mixed values: 0x00005000 clips to 0x5000, 0xffff0000 clips to 0x8000
  TEST_CASE_D32( 5, x10, x11, 0x50008000, \
    li  x10, 0x00005000; \
    li  x11, 0xffff0000; \
    pnclip.hs x8, x10; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclip.hs x8, x10; \
  )

  # Negative values: 0xffff8000 clips to 0x8000 (-32768)
  TEST_CASE_D32( 7, x10, x11, 0x80008000, \
    li  x10, 0xffff8000; \
    li  x11, 0xffff8000; \
    pnclip.hs x8, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

