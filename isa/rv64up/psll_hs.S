# See LICENSE for license details.

#*****************************************************************************
# psll_hs.S
#-----------------------------------------------------------------------------
#
# Test psll.hs instruction (packed shift left logical halfword).
# Operates on 32-bit register: rd = rs1 << (rs2 & 0xf)
# 2 elements of 16-bits each, logical shift left
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x00010001 << 0 = 0x00010001
  TEST_CASE( 2, x14, 0x00010001, \
    li  x13, 0x00010001; \
    li  x11, 0; \
    psll.hs x14, x13, x11; \
  )

  # Shift by 1: 0x00010001 << 1 = 0x00020002
  TEST_CASE( 3, x14, 0x00020002, \
    li  x13, 0x00010001; \
    li  x11, 1; \
    psll.hs x14, x13, x11; \
  )

  # Shift by 2: 0x00030003 << 2 = 0x000c000c
  TEST_CASE( 4, x14, 0x000c000c, \
    li  x13, 0x00030003; \
    li  x11, 2; \
    psll.hs x14, x13, x11; \
  )

  # Shift by 4: 0x000f000f << 4 = 0x00f000f0
  TEST_CASE( 5, x14, 0x00f000f0, \
    li  x13, 0x000f000f; \
    li  x11, 4; \
    psll.hs x14, x13, x11; \
  )

  # Shift by 8: 0x00010001 << 8 = 0x01000100
  TEST_CASE( 6, x14, 0x01000100, \
    li  x13, 0x00010001; \
    li  x11, 8; \
    psll.hs x14, x13, x11; \
  )

  # Shift by 15: 0x00010001 << 15 = 0x80008000
  TEST_CASE( 7, x14, 0x80008000, \
    li  x13, 0x00010001; \
    li  x11, 15; \
    psll.hs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

