# See LICENSE for license details.

#*****************************************************************************
# pnclipu_hs.S
#-----------------------------------------------------------------------------
#
# Test pnclipu.hs instruction (packed narrowing clip unsigned halfword).
# Clips 32-bit packed values to 16-bit unsigned range [0, 65535].
# Operates on 64-bit register pairs with 2 32-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x00001000 clips to 0x1000
  TEST_CASE_D32( 2, x10, x11, 0x10001000, \
    li  x10, 0x00001000; \
    li  x11, 0x00001000; \
    pnclipu.hs x8, x10; \
  )

  # Saturation at max: 0x00020000 saturates to 0xffff
  TEST_CASE_D32( 3, x10, x11, 0xffffffff, \
    li  x10, 0x00020000; \
    li  x11, 0x00020000; \
    pnclipu.hs x8, x10; \
  )

  # Negative clipped to 0: 0xffff0000 clips to 0x0000
  TEST_CASE_D32( 4, x10, x11, 0x00000000, \
    li  x10, 0xffff0000; \
    li  x11, 0xffff0000; \
    pnclipu.hs x8, x10; \
  )

  # Mixed values: 0x00005000 clips to 0x5000, 0xffff0000 clips to 0x0000
  TEST_CASE_D32( 5, x10, x11, 0x50000000, \
    li  x10, 0x00005000; \
    li  x11, 0xffff0000; \
    pnclipu.hs x8, x10; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipu.hs x8, x10; \
  )

  # Max value: 0x0000ffff clips to 0xffff
  TEST_CASE_D32( 7, x10, x11, 0xffffffff, \
    li  x10, 0x0000ffff; \
    li  x11, 0x0000ffff; \
    pnclipu.hs x8, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

