# See LICENSE for license details.

#*****************************************************************************
# pabdsumu_b.S
#-----------------------------------------------------------------------------
#
# Test pabdsumu.b instruction (packed unsigned absolute difference sum byte).
# Operates on 32-bit register: rd = sum(|rs1 - rs2|) for all byte elements
# 4 elements of 8-bits each, summed into a single result
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All zeros: sum(|0 - 0|) = 0
  TEST_CASE( 2, x14, 0x00000000, \
    li  x11, 0x00000000; \
    li  x13, 0x00000000; \
    pabdsumu.b x14, x11, x13; \
  )

  # All same: sum(|5 - 5|) = 0
  TEST_CASE( 3, x14, 0x00000000, \
    li  x11, 0x05050505; \
    li  x13, 0x05050505; \
    pabdsumu.b x14, x11, x13; \
  )

  # Simple sum: sum(|10 - 4|) = 6*4 = 24
  TEST_CASE( 4, x14, 0x00000018, \
    li  x11, 0x0a0a0a0a; \
    li  x13, 0x04040404; \
    pabdsumu.b x14, x11, x13; \
  )

  # Mixed values: sum(|10 - 4| + |20 - 5| + |30 - 10| + |40 - 20|) = 6+15+20+20 = 61
  TEST_CASE( 5, x14, 0x0000003d, \
    li  x11, 0x281e140a; \
    li  x13, 0x140a0504; \
    pabdsumu.b x14, x11, x13; \
  )

  # Max difference: sum(|255 - 0|) = 255*4 = 1020
  TEST_CASE( 6, x14, 0x000003fc, \
    li  x11, 0xffffffff; \
    li  x13, 0x00000000; \
    pabdsumu.b x14, x11, x13; \
  )

  # Alternating: sum(|100 - 50| + |200 - 100|) = 50+100+50+100 = 300
  TEST_CASE( 7, x14, 0x0000012c, \
    li  x11, 0xc86464c8; \
    li  x13, 0x64326432; \
    pabdsumu.b x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

