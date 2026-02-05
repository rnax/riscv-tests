# See LICENSE for license details.

#*****************************************************************************
# psh1add_w.S
#-----------------------------------------------------------------------------
#
# Test psh1add.w instruction (packed shift left 1 and add word).
# Operates on 64-bit register: rd = (rs1 << 1) + rs2
# 2 elements of 32-bits each, shift left 1 and add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: (0x00000001 << 1) + 0x00000001 = 0x00000003
  TEST_CASE( 2, x14, 0x0000000300000003, \
    li  x13, 0x0000000100000001; \
    li  x12, 0x0000000100000001; \
    psh1add.w x14, x13, x12; \
  )

  # Add with different values: (0x00000002 << 1) + 0x00000001 = 0x00000005
  TEST_CASE( 3, x14, 0x0000000500000005, \
    li  x13, 0x0000000200000002; \
    li  x12, 0x0000000100000001; \
    psh1add.w x14, x13, x12; \
  )

  # Add with larger values: (0x00001000 << 1) + 0x00001000 = 0x00003000
  TEST_CASE( 4, x14, 0x0000300000003000, \
    li  x13, 0x0000100000001000; \
    li  x12, 0x0000100000001000; \
    psh1add.w x14, x13, x12; \
  )

  # Add with negative values: (0x80000000 << 1) + 0x00000001 = 0x00000001
  TEST_CASE( 5, x14, 0x0000000100000001, \
    li  x13, 0x8000000080000000; \
    li  x12, 0x0000000100000001; \
    psh1add.w x14, x13, x12; \
  )

  # Add with zero: (0x00000001 << 1) + 0x00000000 = 0x00000002
  TEST_CASE( 6, x14, 0x0000000200000002, \
    li  x13, 0x0000000100000001; \
    li  x12, 0x0000000000000000; \
    psh1add.w x14, x13, x12; \
  )

  # Add with max values: (0x7fffffff << 1) + 0x00000001 = 0xffffffff
  TEST_CASE( 7, x14, 0xffffffff00000001, \
    li  x13, 0x7fffffff7fffffff; \
    li  x12, 0x0000000100000001; \
    psh1add.w x14, x13, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

