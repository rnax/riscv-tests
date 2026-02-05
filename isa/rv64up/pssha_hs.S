# See LICENSE for license details.

#*****************************************************************************
# pssha_hs.S
#-----------------------------------------------------------------------------
#
# Test pssha.hs instruction (packed saturating shift left arithmetic halfword).
# Operates on 32-bit register: rd = saturate(rs1 << (rs2 & 0xf))
# 2 elements of 16-bits each, saturating shift left arithmetic
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
    pssha.hs x14, x13, x11; \
  )

  # Shift by 1: 0x00010001 << 1 = 0x00020002
  TEST_CASE( 3, x14, 0x00020002, \
    li  x13, 0x00010001; \
    li  x11, 1; \
    pssha.hs x14, x13, x11; \
  )

  # Shift by 4: 0x00010001 << 4 = 0x00100010
  TEST_CASE( 4, x14, 0x00100010, \
    li  x13, 0x00010001; \
    li  x11, 4; \
    pssha.hs x14, x13, x11; \
  )

  # Saturate positive: 0x40004000 << 1 = 0x7fff7fff (saturated)
  TEST_CASE( 5, x14, 0x7fff7fff, \
    li  x13, 0x40004000; \
    li  x11, 1; \
    pssha.hs x14, x13, x11; \
  )

  # Saturate negative: 0x80008000 << 1 = 0x80008000 (saturated)
  TEST_CASE( 6, x14, 0x80008000, \
    li  x13, 0x80008000; \
    li  x11, 1; \
    pssha.hs x14, x13, x11; \
  )

  # Shift by 15: 0x00010001 << 15 = 0x80008000
  TEST_CASE( 7, x14, 0x80008000, \
    li  x13, 0x00010001; \
    li  x11, 15; \
    pssha.hs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

