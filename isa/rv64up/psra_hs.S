# See LICENSE for license details.

#*****************************************************************************
# psra_hs.S
#-----------------------------------------------------------------------------
#
# Test psra.hs instruction (packed shift right arithmetic halfword).
# Operates on 32-bit register: rd = rs1 >> (rs2 & 0xf) (arithmetic)
# 2 elements of 16-bits each, arithmetic shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x80008000 >> 0 = 0x80008000
  TEST_CASE( 2, x14, 0x80008000, \
    li  x13, 0x80008000; \
    li  x11, 0; \
    psra.hs x14, x13, x11; \
  )

  # Shift by 1: 0x80008000 >> 1 = 0xc000c000 (sign extended)
  TEST_CASE( 3, x14, 0xc000c000, \
    li  x13, 0x80008000; \
    li  x11, 1; \
    psra.hs x14, x13, x11; \
  )

  # Shift by 2: 0x80008000 >> 2 = 0xe000e000
  TEST_CASE( 4, x14, 0xe000e000, \
    li  x13, 0x80008000; \
    li  x11, 2; \
    psra.hs x14, x13, x11; \
  )

  # Shift by 4: 0x80008000 >> 4 = 0xf800f800
  TEST_CASE( 5, x14, 0xf800f800, \
    li  x13, 0x80008000; \
    li  x11, 4; \
    psra.hs x14, x13, x11; \
  )

  # Positive value: 0x7fff7fff >> 1 = 0x3fff3fff
  TEST_CASE( 6, x14, 0x3fff3fff, \
    li  x13, 0x7fff7fff; \
    li  x11, 1; \
    psra.hs x14, x13, x11; \
  )

  # Shift by 15: 0x80008000 >> 15 = 0xffffffff
  TEST_CASE( 7, x14, 0xffffffff, \
    li  x13, 0x80008000; \
    li  x11, 15; \
    psra.hs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

