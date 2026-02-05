# See LICENSE for license details.

#*****************************************************************************
# psshar_ws.S
#-----------------------------------------------------------------------------
#
# Test psshar.ws instruction (packed saturating shift right arithmetic with rounding word).
# Operates on 64-bit register: rd = saturate((rs1 >> (rs2 & 0x1f)) + rounding)
# 2 elements of 32-bits each, saturating shift right arithmetic with rounding
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x8000000080000000 >> 0 = 0x8000000080000000 (no rounding)
  TEST_CASE( 2, x14, 0x8000000080000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 0; \
    psshar.ws x14, x13, x11; \
  )

  # Shift by 1 with rounding: 0x8000000080000000 >> 1 + round = 0xc000000c0000001
  TEST_CASE( 3, x14, 0xc000000c0000001, \
    li  x13, 0x8000000080000000; \
    li  x11, 1; \
    psshar.ws x14, x13, x11; \
  )

  # Shift by 2 with rounding: 0x8000000080000000 >> 2 + round = 0xe000000e0000000
  TEST_CASE( 4, x14, 0xe000000e0000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 2; \
    psshar.ws x14, x13, x11; \
  )

  # Shift by 4 with rounding: 0x8000000080000000 >> 4 + round = 0xf800000f8000000
  TEST_CASE( 5, x14, 0xf800000f8000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 4; \
    psshar.ws x14, x13, x11; \
  )

  # Positive value: 0x7fffffff7fffffff >> 1 + round = 0x4000000040000000
  TEST_CASE( 6, x14, 0x4000000040000000, \
    li  x13, 0x7fffffff7fffffff; \
    li  x11, 1; \
    psshar.ws x14, x13, x11; \
  )

  # Shift by 16 with rounding: 0x8000000080000000 >> 16 + round = 0xffff8000ffff8000
  TEST_CASE( 7, x14, 0xffff8000ffff8000, \
    li  x13, 0x8000000080000000; \
    li  x11, 16; \
    psshar.ws x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

