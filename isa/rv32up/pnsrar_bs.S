# See LICENSE for license details.

#*****************************************************************************
# pnsrar_bs.S
#-----------------------------------------------------------------------------
#
# Test pnsrar.bs instruction (packed narrowing shift right arithmetic with rounding byte).
# Narrows 16-bit values to 8-bit with rounding: rd = ((int16_t)(rs1) >> shamt) + round_bit
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests with rounding
  #-------------------------------------------------------------

  # No shift: 0x0005 >> 0 = 0x05 (no rounding)
  TEST_CASE_D32( 2, x10, x11, 0x00000005, \
    li  x10, 0x00000005; \
    li  x12, 0; \
    pnsrar.bs x8, x10, x12; \
  )

  # Shift by 1: 0x0010 >> 1 = 0x08, round_bit = 0
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    li  x12, 1; \
    pnsrar.bs x8, x10, x12; \
  )

  # Shift by 1 with rounding: 0x0011 >> 1 = 0x08, round_bit = 1, result = 0x09
  TEST_CASE_D32( 4, x10, x11, 0x00000009, \
    li  x10, 0x00000011; \
    li  x12, 1; \
    pnsrar.bs x8, x10, x12; \
  )

  # Negative with rounding: 0xff00 >> 1 = 0xff80, round_bit = 0
  TEST_CASE_D32( 5, x10, x11, 0xffffff80, \
    li  x10, 0x0000ff00; \
    li  x12, 1; \
    pnsrar.bs x8, x10, x12; \
  )

  # Negative with rounding: 0xff01 >> 1 = 0xff80, round_bit = 1, result = 0xff81
  TEST_CASE_D32( 6, x10, x11, 0xffffff81, \
    li  x10, 0x0000ff01; \
    li  x12, 1; \
    pnsrar.bs x8, x10, x12; \
  )

  # Shift by 4: 0x00f0 >> 4 = 0x0f, round_bit = 0
  TEST_CASE_D32( 7, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    li  x12, 4; \
    pnsrar.bs x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

