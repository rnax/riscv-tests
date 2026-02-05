# See LICENSE for license details.

#*****************************************************************************
# psh1add_h.S
#-----------------------------------------------------------------------------
#
# Test psh1add.h instruction (packed shift left 1 and add halfword).
# Operates on 32-bit register: rd = (rs1 << 1) + rs2
# 2 elements of 16-bits each, shift left 1 and add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: (0x00010001 << 1) + 0x00010001 = 0x00030003
  TEST_CASE( 2, x14, 0x00030003, \
    li  x13, 0x00010001; \
    li  x12, 0x00010001; \
    psh1add.h x14, x13, x12; \
  )

  # Add with different values: (0x00020002 << 1) + 0x00010001 = 0x00050005
  TEST_CASE( 3, x14, 0x00050005, \
    li  x13, 0x00020002; \
    li  x12, 0x00010001; \
    psh1add.h x14, x13, x12; \
  )

  # Add with larger values: (0x00100010 << 1) + 0x00100010 = 0x00300030
  TEST_CASE( 4, x14, 0x00300030, \
    li  x13, 0x00100010; \
    li  x12, 0x00100010; \
    psh1add.h x14, x13, x12; \
  )

  # Add with negative values: (0x80008000 << 1) + 0x00010001 = 0x00010001
  TEST_CASE( 5, x14, 0x00010001, \
    li  x13, 0x80008000; \
    li  x12, 0x00010001; \
    psh1add.h x14, x13, x12; \
  )

  # Add with zero: (0x00010001 << 1) + 0x00000000 = 0x00020002
  TEST_CASE( 6, x14, 0x00020002, \
    li  x13, 0x00010001; \
    li  x12, 0x00000000; \
    psh1add.h x14, x13, x12; \
  )

  # Add with max values: (0x7fff7fff << 1) + 0x00010001 = 0xffff0001
  TEST_CASE( 7, x14, 0xffff0001, \
    li  x13, 0x7fff7fff; \
    li  x12, 0x00010001; \
    psh1add.h x14, x13, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

