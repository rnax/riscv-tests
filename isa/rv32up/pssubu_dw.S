# See LICENSE for license details.

#*****************************************************************************
# pssubu_dw.S
#-----------------------------------------------------------------------------
#
# Test pssubu_dw instruction (packed unsigned saturating subtract double-word).
# Operates on 64-bit register pairs with unsigned saturation.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit unsigned saturating subtract: 0x0000000a - 0x00000004 = 0x00000006
  TEST_CASE_D32( 2, x14, x15, 0x0000000600000006, \
    li  x11, 0x0000000a; \
    li  x12, 0x00000000; \
    li  x13, 0x00000004; \
    li  x16, 0x00000000; \
    pssubu_dw x14, x11, x13; \
  )

  # Underflow saturation: 0x00000004 - 0x0000000a = 0x00000000 (saturated)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000004; \
    li  x12, 0x00000004; \
    li  x13, 0x0000000a; \
    li  x16, 0x0000000a; \
    pssubu_dw x14, x11, x13; \
  )

  # Zero cases: 0x00000000 - 0x00000000 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pssubu_dw x14, x11, x13; \
  )

  # Max value: 0xffffffff - 0x00000001 = 0xfffffffe
  TEST_CASE_D32( 5, x14, x15, 0xfffffffffffffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x00000001; \
    li  x16, 0x00000001; \
    pssubu_dw x14, x11, x13; \
  )

  # Same values: 0xaaaaaaaa - 0xaaaaaaaa = 0x00000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    li  x16, 0xaaaaaaaa; \
    pssubu_dw x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

