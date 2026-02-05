# See LICENSE for license details.

#*****************************************************************************
# psh1add_dw.S
#-----------------------------------------------------------------------------
#
# Test psh1add.dw instruction (packed shift left 1 and add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 << 1) + rs2:rs2+1
# 2 elements of 32-bits each, wrapping add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: ((2 << 1) + 3) = 7
  TEST_CASE_D32( 2, x14, x15, 0x0000000700000007, \
    li  x10, 0x00000002; \
    li  x11, 0x00000002; \
    li  x12, 0x00000003; \
    li  x13, 0x00000003; \
    psh1add.dw x14, x10, x12; \
  )

  # ((5 << 1) + 10) = 20
  TEST_CASE_D32( 3, x14, x15, 0x0000001400000014, \
    li  x10, 0x00000005; \
    li  x11, 0x00000005; \
    li  x12, 0x0000000a; \
    li  x13, 0x0000000a; \
    psh1add.dw x14, x10, x12; \
  )

  # Wrapping: ((0x80000000 << 1) + 0x80000000) wraps in 32-bit
  TEST_CASE_D32( 4, x14, x15, 0x8000000080000000, \
    li  x10, 0x80000000; \
    li  x11, 0x80000000; \
    li  x12, 0x80000000; \
    li  x13, 0x80000000; \
    psh1add.dw x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    psh1add.dw x14, x10, x12; \
  )

  # ((100 << 1) + 50) = 250
  TEST_CASE_D32( 6, x14, x15, 0x000000fa000000fa, \
    li  x10, 0x00000064; \
    li  x11, 0x00000064; \
    li  x12, 0x00000032; \
    li  x13, 0x00000032; \
    psh1add.dw x14, x10, x12; \
  )

  # Negative operands: ((-2 << 1) + (-3)) = -7
  TEST_CASE_D32( 7, x14, x15, 0xfffffff9fffffff9, \
    li  x10, 0xfffffffe; \
    li  x11, 0xfffffffe; \
    li  x12, 0xfffffffd; \
    li  x13, 0xfffffffd; \
    psh1add.dw x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

