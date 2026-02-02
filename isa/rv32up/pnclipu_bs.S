# See LICENSE for license details.

#*****************************************************************************
# pnclipu_bs.S
#-----------------------------------------------------------------------------
#
# Test pnclipu.bs instruction (packed narrowing clip unsigned byte).
# Clips 16-bit packed values to 8-bit unsigned range [0, 255].
# Operates on 64-bit register pairs with 4 16-bit elements.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0010 clips to 0x10
  TEST_CASE_D32( 2, x10, x11, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    pnclipu.bs x8, x10; \
  )

  # Saturation at max: 0x0200 saturates to 0xff
  TEST_CASE_D32( 3, x10, x11, 0xffffffff, \
    li  x10, 0x02000200; \
    li  x11, 0x02000200; \
    pnclipu.bs x8, x10; \
  )

  # Negative clipped to 0: 0xff00 clips to 0x00
  TEST_CASE_D32( 4, x10, x11, 0x00000000, \
    li  x10, 0xff00ff00; \
    li  x11, 0xff00ff00; \
    pnclipu.bs x8, x10; \
  )

  # Mixed values: 0x0050 clips to 0x50, 0xff00 clips to 0x00
  TEST_CASE_D32( 5, x10, x11, 0x50500000, \
    li  x10, 0x00500050; \
    li  x11, 0xff00ff00; \
    pnclipu.bs x8, x10; \
  )

  # Zero input
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pnclipu.bs x8, x10; \
  )

  # Max value: 0x00ff clips to 0xff
  TEST_CASE_D32( 7, x10, x11, 0xffffffff, \
    li  x10, 0x00ff00ff; \
    li  x11, 0x00ff00ff; \
    pnclipu.bs x8, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

