# See LICENSE for license details.

#*****************************************************************************
# pnsrar_hs.S
#-----------------------------------------------------------------------------
#
# Test pnsrar.hs instruction (packed narrowing shift right arithmetic with rounding halfword).
# Narrows 32-bit values to 16-bit with rounding: rd = ((int32_t)(rs1) >> shamt) + round_bit
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests with rounding
  #-------------------------------------------------------------

  # No shift: 0x00000005 >> 0 = 0x0005 (no rounding)
  TEST_CASE_D32( 2, x10, x11, 0x00000005, \
    li  x10, 0x00000005; \
    li  x12, 0; \
    pnsrar.hs x8, x10, x12; \
  )

  # Shift by 1: 0x00000010 >> 1 = 0x0008, round_bit = 0
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    li  x12, 1; \
    pnsrar.hs x8, x10, x12; \
  )

  # Shift by 1 with rounding: 0x00000011 >> 1 = 0x0008, round_bit = 1, result = 0x0009
  TEST_CASE_D32( 4, x10, x11, 0x00000009, \
    li  x10, 0x00000011; \
    li  x12, 1; \
    pnsrar.hs x8, x10, x12; \
  )

  # Negative with rounding: 0xffff0000 >> 1 = 0xffff8000, round_bit = 0
  TEST_CASE_D32( 5, x10, x11, 0xffff8000, \
    li  x10, 0xffff0000; \
    li  x12, 1; \
    pnsrar.hs x8, x10, x12; \
  )

  # Negative with rounding: 0xffff0001 >> 1 = 0xffff8000, round_bit = 1, result = 0xffff8001
  TEST_CASE_D32( 6, x10, x11, 0xffff8001, \
    li  x10, 0xffff0001; \
    li  x12, 1; \
    pnsrar.hs x8, x10, x12; \
  )

  # Shift by 8: 0x0000ff00 >> 8 = 0x00ff, round_bit = 0
  TEST_CASE_D32( 7, x10, x11, 0x000000ff, \
    li  x10, 0x0000ff00; \
    li  x12, 8; \
    pnsrar.hs x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

