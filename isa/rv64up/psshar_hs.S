# See LICENSE for license details.

#*****************************************************************************
# psshar_hs.S
#-----------------------------------------------------------------------------
#
# Test psshar.hs instruction (packed saturating shift left arithmetic with rounding halfword).
# Operates on 32-bit register: rd = saturate((rs1 << (rs2 & 0xf)) + rounding)
# 2 elements of 16-bits each, saturating shift left arithmetic with rounding
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x00010001 << 0 = 0x00010001 (no rounding)
  TEST_CASE( 2, x14, 0x00010001, \
    li  x13, 0x00010001; \
    li  x11, 0; \
    psshar.hs x14, x13, x11; \
  )

  # Shift by 1 with rounding: 0x00010001 << 1 + round = 0x00020002
  TEST_CASE( 3, x14, 0x00020002, \
    li  x13, 0x00010001; \
    li  x11, 1; \
    psshar.hs x14, x13, x11; \
  )

  # Shift by 4 with rounding: 0x00010001 << 4 + round = 0x00100010
  TEST_CASE( 4, x14, 0x00100010, \
    li  x13, 0x00010001; \
    li  x11, 4; \
    psshar.hs x14, x13, x11; \
  )

  # Saturate positive with rounding: 0x40004000 << 1 + round = 0x7fff7fff
  TEST_CASE( 5, x14, 0x7fff7fff, \
    li  x13, 0x40004000; \
    li  x11, 1; \
    psshar.hs x14, x13, x11; \
  )

  # Saturate negative with rounding: 0x80008000 << 1 + round = 0x80008000
  TEST_CASE( 6, x14, 0x80008000, \
    li  x13, 0x80008000; \
    li  x11, 1; \
    psshar.hs x14, x13, x11; \
  )

  # Shift by 15 with rounding: 0x00010001 << 15 + round = 0x80008000
  TEST_CASE( 7, x14, 0x80008000, \
    li  x13, 0x00010001; \
    li  x11, 15; \
    psshar.hs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

