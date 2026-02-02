# See LICENSE for license details.

#*****************************************************************************
# pnsrai_b.S
#-----------------------------------------------------------------------------
#
# Test pnsrai.b instruction (packed narrowing shift right arithmetic immediate byte).
# Narrows 16-bit values to 8-bit with immediate shift: rd = (int16_t)(rs1) >> shamt
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x0005 >> 0 = 0x05
  TEST_CASE_D32( 2, x10, x11, 0x00000005, \
    li  x10, 0x00000005; \
    pnsrai.b x8, x10, 0; \
  )

  # Shift by 1: 0x0010 >> 1 = 0x08
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    pnsrai.b x8, x10, 1; \
  )

  # Shift by 4: 0x00f0 >> 4 = 0x0f
  TEST_CASE_D32( 4, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    pnsrai.b x8, x10, 4; \
  )

  # Negative: 0xff00 >> 1 = 0xff80 (sign extended, masked to 8-bit = 0x80)
  TEST_CASE_D32( 5, x10, x11, 0xffffff80, \
    li  x10, 0x0000ff00; \
    pnsrai.b x8, x10, 1; \
  )

  # Negative: 0x8000 >> 4 = 0xf800 (sign extended, masked to 8-bit = 0xf8)
  TEST_CASE_D32( 6, x10, x11, 0xfffffff8, \
    li  x10, 0x00008000; \
    pnsrai.b x8, x10, 4; \
  )

  # Shift by 15: 0x7fff >> 15 = 0x0000
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00007fff; \
    pnsrai.b x8, x10, 15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

