# See LICENSE for license details.

#*****************************************************************************
# pssh1sadd_h.S
#-----------------------------------------------------------------------------
#
# Test pssh1sadd.h instruction (packed saturating shift left 1 and add halfword).
# Operates on 32-bit register: rd = saturate((rs1 << 1) + rs2)
# 2 elements of 16-bits each, saturating shift left 1 and add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: saturate((0x00010001 << 1) + 0x00010001) = 0x00030003
  TEST_CASE( 2, x14, 0x00030003, \
    li  x13, 0x00010001; \
    li  x12, 0x00010001; \
    pssh1sadd.h x14, x13, x12; \
  )

  # Add with different values: saturate((0x00020002 << 1) + 0x00010001) = 0x00050005
  TEST_CASE( 3, x14, 0x00050005, \
    li  x13, 0x00020002; \
    li  x12, 0x00010001; \
    pssh1sadd.h x14, x13, x12; \
  )

  # Add with larger values: saturate((0x00100010 << 1) + 0x00100010) = 0x00300030
  TEST_CASE( 4, x14, 0x00300030, \
    li  x13, 0x00100010; \
    li  x12, 0x00100010; \
    pssh1sadd.h x14, x13, x12; \
  )

  # Saturate positive: saturate((0x40004000 << 1) + 0x00010001) = 0x7fff7fff
  TEST_CASE( 5, x14, 0x7fff7fff, \
    li  x13, 0x40004000; \
    li  x12, 0x00010001; \
    pssh1sadd.h x14, x13, x12; \
  )

  # Saturate negative: saturate((0x80008000 << 1) + 0x80008000) = 0x80008000
  TEST_CASE( 6, x14, 0x80008000, \
    li  x13, 0x80008000; \
    li  x12, 0x80008000; \
    pssh1sadd.h x14, x13, x12; \
  )

  # Add with zero: saturate((0x00010001 << 1) + 0x00000000) = 0x00020002
  TEST_CASE( 7, x14, 0x00020002, \
    li  x13, 0x00010001; \
    li  x12, 0x00000000; \
    pssh1sadd.h x14, x13, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

