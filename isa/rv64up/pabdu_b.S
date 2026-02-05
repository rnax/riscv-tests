# See LICENSE for license details.

#*****************************************************************************
# pabdu_b.S
#-----------------------------------------------------------------------------
#
# Test pabdu.b instruction (packed unsigned absolute difference byte).
# Operates on 32-bit register: rd = |rs1 - rs2| (unsigned)
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
    pabdu.b x14, x11, x13; \
  )

  # Reverse difference: |4 - 10| = 6
  TEST_CASE( 3, x14, 0x06060606, \
    li  x11, 0x04040404; \
    li  x13, 0x0a0a0a0a; \
    pabdu.b x14, x11, x13; \
  )

  # Zero difference: |5 - 5| = 0
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x05050505; \
    li  x13, 0x05050505; \
    pabdu.b x14, x11, x13; \
  )

  # Max values: |255 - 0| = 255
  TEST_CASE( 5, x14, 0xffffffff, \
    li  x11, 0xffffffff; \
    li  x13, 0x00000000; \
    pabdu.b x14, x11, x13; \
  )

  # Large difference: |200 - 50| = 150
  TEST_CASE( 6, x14, 0x96969696, \
    li  x11, 0xc8c8c8c8; \
    li  x13, 0x32323232; \
    pabdu.b x14, x11, x13; \
  )

  # All ones vs all zeros: |255 - 0| = 255
  TEST_CASE( 7, x14, 0xffffffff, \
    li  x11, 0xffffffff; \
    li  x13, 0x00000000; \
    pabdu.b x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

