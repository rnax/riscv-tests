# See LICENSE for license details.

#*****************************************************************************
# pnsrl_bs.S
#-----------------------------------------------------------------------------
#
# Test pnsrl.bs instruction (packed narrowing shift right logical byte).
# Narrows 16-bit values to 8-bit (unsigned): rd = (uint16_t)(rs1) >> (rs2 & 0xF)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical shift tests
  #-------------------------------------------------------------

  # No shift: 0x0005 >> 0 = 0x05
  TEST_CASE_D32( 2, x10, x11, 0x00000005, \
    li  x10, 0x00000005; \
    li  x12, 0; \
    pnsrl.bs x8, x10, x12; \
  )

  # Shift by 1: 0x0010 >> 1 = 0x08
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    li  x12, 1; \
    pnsrl.bs x8, x10, x12; \
  )

  # Shift by 4: 0x00f0 >> 4 = 0x0f
  TEST_CASE_D32( 4, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    li  x12, 4; \
    pnsrl.bs x8, x10, x12; \
  )

  # Unsigned: 0xff00 >> 1 = 0x7f80 (logical, not sign extended, masked to 8-bit = 0x80)
  TEST_CASE_D32( 5, x10, x11, 0x00000080, \
    li  x10, 0x0000ff00; \
    li  x12, 1; \
    pnsrl.bs x8, x10, x12; \
  )

  # Unsigned: 0x8000 >> 4 = 0x0800 (logical, masked to 8-bit = 0x00)
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00008000; \
    li  x12, 4; \
    pnsrl.bs x8, x10, x12; \
  )

  # Shift by 15: 0x7fff >> 15 = 0x0000
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00007fff; \
    li  x12, 15; \
    pnsrl.bs x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

