# See LICENSE for license details.

#*****************************************************************************
# pabd_h.S
#-----------------------------------------------------------------------------
#
# Test pabd.h instruction (packed signed absolute difference halfword).
# Operates on 32-bit register: rd = |rs1 - rs2|
# 2 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |1000 - 500| = 500
  TEST_CASE( 2, x14, 0x01f401f4, \
    li  x11, 0x03e803e8; \
    li  x13, 0x01f401f4; \
    pabd.h x14, x11, x13; \
  )

  # Negative difference: |500 - 1000| = 500
  TEST_CASE( 3, x14, 0x01f401f4, \
    li  x11, 0x01f401f4; \
    li  x13, 0x03e803e8; \
    pabd.h x14, x11, x13; \
  )

  # Zero difference: |5000 - 5000| = 0
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x13881388; \
    li  x13, 0x13881388; \
    pabd.h x14, x11, x13; \
  )

  # Large values: |65535 - 1| = 65534
  TEST_CASE( 5, x14, 0xfffeffff, \
    li  x11, 0xffffffff; \
    li  x13, 0x00010001; \
    pabd.h x14, x11, x13; \
  )

  # Wrapping case: |10000 - 20000| = 10000
  TEST_CASE( 6, x14, 0x27102710, \
    li  x11, 0x27102710; \
    li  x13, 0x4e204e20; \
    pabd.h x14, x11, x13; \
  )

  # Negative operands: |-5000 - (-10000)| = 5000
  TEST_CASE( 7, x14, 0x13881388, \
    li  x11, 0xec78ec78; \
    li  x13, 0xd8f0d8f0; \
    pabd.h x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

