# See LICENSE for license details.

#*****************************************************************************
# psrl_hs.S
#-----------------------------------------------------------------------------
#
# Test psrl.hs instruction (packed shift right logical halfword).
# Operates on 32-bit register: rd = rs1 >> (rs2 & 0xf) (logical)
# 2 elements of 16-bits each, logical shift right
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
    psrl.hs x14, x13, x11; \
  )

  # Shift by 1: 0x80008000 >> 1 = 0x40004000 (logical, no sign extension)
  TEST_CASE( 3, x14, 0x40004000, \
    li  x13, 0x80008000; \
    li  x11, 1; \
    psrl.hs x14, x13, x11; \
  )

  # Shift by 2: 0x80008000 >> 2 = 0x20002000
  TEST_CASE( 4, x14, 0x20002000, \
    li  x13, 0x80008000; \
    li  x11, 2; \
    psrl.hs x14, x13, x11; \
  )

  # Shift by 4: 0x80008000 >> 4 = 0x08000800
  TEST_CASE( 5, x14, 0x08000800, \
    li  x13, 0x80008000; \
    li  x11, 4; \
    psrl.hs x14, x13, x11; \
  )

  # Shift by 8: 0x80008000 >> 8 = 0x00800080
  TEST_CASE( 6, x14, 0x00800080, \
    li  x13, 0x80008000; \
    li  x11, 8; \
    psrl.hs x14, x13, x11; \
  )

  # Shift by 15: 0x80008000 >> 15 = 0x00010001
  TEST_CASE( 7, x14, 0x00010001, \
    li  x13, 0x80008000; \
    li  x11, 15; \
    psrl.hs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

