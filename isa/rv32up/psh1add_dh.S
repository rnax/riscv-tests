# See LICENSE for license details.

#*****************************************************************************
# psh1add_dh.S
#-----------------------------------------------------------------------------
#
# Test psh1add.dh instruction (packed shift left 1 and add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 << 1) + rs2:rs2+1
# 4 elements of 16-bits each, wrapping add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: ((2 << 1) + 3) = 7 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x00070007, \
    li  x10, 0x00020002; \
    li  x11, 0x00000000; \
    li  x12, 0x00030003; \
    li  x13, 0x00000000; \
    psh1add.dh x14, x10, x12; \
  )

  # ((5 << 1) + 10) = 20 for each halfword
  TEST_CASE_D32( 3, x14, x15, 0x0014, \
    li  x10, 0x00050005; \
    li  x11, 0x00000000; \
    li  x12, 0x000a000a; \
    li  x13, 0x00000000; \
    psh1add.dh x14, x10, x12; \
  )

  # Wrapping: ((40000 << 1) + 30000) wraps in 16-bit
  TEST_CASE_D32( 4, x14, x15, 0x3c703c70, \
    li  x10, 0x9c409c40; \
    li  x11, 0x00000000; \
    li  x12, 0x75307530; \
    li  x13, 0x00000000; \
    psh1add.dh x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    psh1add.dh x14, x10, x12; \
  )

  # ((100 << 1) + 50) = 250 for each halfword
  TEST_CASE_D32( 6, x14, x15, 0x00fa00fa, \
    li  x10, 0x00640064; \
    li  x11, 0x00000000; \
    li  x12, 0x00320032; \
    li  x13, 0x00000000; \
    psh1add.dh x14, x10, x12; \
  )

  # Negative operands: ((-2 << 1) + (-3)) = -7
  TEST_CASE_D32( 7, x14, x15, 0xfff9fff9, \
    li  x10, 0xfffefffe; \
    li  x11, 0x00000000; \
    li  x12, 0xfffdffd; \
    li  x13, 0x00000000; \
    psh1add.dh x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

