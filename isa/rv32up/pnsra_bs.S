# See LICENSE for license details.

#*****************************************************************************
# pnsra_bs.S
#-----------------------------------------------------------------------------
#
# Test pnsra.bs instruction (packed narrowing shift right arithmetic byte).
# Narrows 16-bit values to 8-bit: rd = (int16_t)(rs1) >> (rs2 & 0xF)
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
    li  x11, 0x00000000; \
    li  x12, 0; \
    pnsra.bs x8, x10, x12; \
  )

  # Shift by 1: 0x0010 >> 1 = 0x08
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    li  x11, 0x00000000; \
    li  x12, 1; \
    pnsra.bs x8, x10, x12; \
  )

  # Shift by 4: 0x00f0 >> 4 = 0x0f
  TEST_CASE_D32( 4, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    li  x11, 0x00000000; \
    li  x12, 4; \
    pnsra.bs x8, x10, x12; \
  )

  # Negative: 0xff00 >> 1 = 0xff80 (sign extended, masked to 8-bit = 0x80)
  TEST_CASE_D32( 5, x10, x11, 0xffffff80, \
    li  x10, 0x0000ff00; \
    li  x11, 0xffffffff; \
    li  x12, 1; \
    pnsra.bs x8, x10, x12; \
  )

  # Negative: 0x8000 >> 4 = 0xf800 (sign extended, masked to 8-bit = 0xf8)
  TEST_CASE_D32( 6, x10, x11, 0xfffffff8, \
    li  x10, 0x00008000; \
    li  x11, 0xffffffff; \
    li  x12, 4; \
    pnsra.bs x8, x10, x12; \
  )

  # Shift by 15: 0x7fff >> 15 = 0x0000
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00007fff; \
    li  x11, 0x00000000; \
    li  x12, 15; \
    pnsra.bs x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

