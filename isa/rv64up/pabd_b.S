# See LICENSE for license details.

#*****************************************************************************
# pabd_b.S
#-----------------------------------------------------------------------------
#
# Test pabd.b instruction (packed signed absolute difference byte).
# Operates on 32-bit register: rd = |rs1 - rs2|
# 4 elements of 8-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |10 - 4| = 6
  TEST_CASE( 2, x14, 0x06060606, \
    li  x11, 0x0a0a0a0a; \
    li  x13, 0x04040404; \
    pabd.b x14, x11, x13; \
  )

  # Negative difference: |4 - 10| = 6
  TEST_CASE( 3, x14, 0x06060606, \
    li  x11, 0x04040404; \
    li  x13, 0x0a0a0a0a; \
    pabd.b x14, x11, x13; \
  )

  # Zero difference: |5 - 5| = 0
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x05050505; \
    li  x13, 0x05050505; \
    pabd.b x14, x11, x13; \
  )

  # Large values: |255 - 1| = 254
  TEST_CASE( 5, x14, 0xfefefefe, \
    li  x11, 0xffffffff; \
    li  x13, 0x01010101; \
    pabd.b x14, x11, x13; \
  )

  # Wrapping case: |100 - 200| = 100
  TEST_CASE( 6, x14, 0x64646464, \
    li  x11, 0x64646464; \
    li  x13, 0xc8c8c8c8; \
    pabd.b x14, x11, x13; \
  )

  # Negative operands: |-50 - (-100)| = 50
  TEST_CASE( 7, x14, 0x32323232, \
    li  x11, 0xcecececece; \
    li  x13, 0x9c9c9c9c; \
    pabd.b x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

