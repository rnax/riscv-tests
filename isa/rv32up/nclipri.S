# See LICENSE for license details.

#*****************************************************************************
# nclipri.S
#-----------------------------------------------------------------------------
#
# Test nclipri instruction (narrowing signed clip with rounding and immediate).
# Clips 64-bit register-pair value shifted right by immediate with rounding to 32-bit signed.
# rd = SAT(P_RS1_PAIR >> shamtd + round_bit)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0000000000000010 >> 0 = 0x00000010 (no rounding)
  TEST_CASE_D32( 2, x10, x11, 0x00000010, \
    li  x10, 0x00000010; \
    li  x10, 0x00000000; \
    nclipri x8, x10, 0; \
  )

  # Right shift by 4 with rounding: 0x00000000000000f8 >> 4 + round = 0x0000000f
  TEST_CASE_D32( 3, x10, x11, 0x0000000f, \
    li  x10, 0x000000f8; \
    li  x10, 0x00000000; \
    nclipri x8, x10, 4; \
  )

  # Saturation at max positive: 0x7fffffffffffffff >> 0 saturates to 0x7fffffff
  TEST_CASE_D32( 4, x10, x11, 0x7fffffff, \
    li  x10, 0xffffffff; \
    li  x10, 0x7fffffff; \
    nclipri x8, x10, 0; \
  )

  # Saturation at min negative: 0x8000000000000000 >> 0 saturates to 0x80000000
  TEST_CASE_D32( 5, x10, x11, 0x80000000, \
    li  x10, 0x00000000; \
    li  x10, 0x80000000; \
    nclipri x8, x10, 0; \
  )

  # Negative value with shift and rounding: 0xfffffffffffffffe >> 1 + round = 0xffffffff
  TEST_CASE_D32( 6, x10, x11, 0x80000000, \
    li  x10, 0xfffffffe; \
    li  x10, 0xffffffff; \
    nclipri x8, x10, 1; \
  )

  # Zero input
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x10, 0x00000000; \
    nclipri x8, x10, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

