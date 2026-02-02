# See LICENSE for license details.

#*****************************************************************************
# pnsrl_hs.S
#-----------------------------------------------------------------------------
#
# Test pnsrl.hs instruction (packed narrowing shift right logical halfword).
# Narrows 32-bit values to 16-bit (unsigned): rd = (uint32_t)(rs1) >> (rs2 & 0x1F)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical shift tests
  #-------------------------------------------------------------

  # No shift: 0x00000005 >> 0 = 0x0005
  TEST_CASE_D32( 2, x10, x11, 0x00000005, \
    li  x10, 0x00000005; \
    li  x12, 0; \
    pnsrl.hs x8, x10, x12; \
  )

  # Shift by 1: 0x00000010 >> 1 = 0x0008
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    li  x12, 1; \
    pnsrl.hs x8, x10, x12; \
  )

  # Shift by 8: 0x0000ff00 >> 8 = 0x00ff
  TEST_CASE_D32( 4, x10, x11, 0x000000ff, \
    li  x10, 0x0000ff00; \
    li  x12, 8; \
    pnsrl.hs x8, x10, x12; \
  )

  # Unsigned: 0xffff0000 >> 1 = 0x7fff8000 (logical, masked to 16-bit = 0x8000)
  TEST_CASE_D32( 5, x10, x11, 0x00008000, \
    li  x10, 0xffff0000; \
    li  x12, 1; \
    pnsrl.hs x8, x10, x12; \
  )

  # Unsigned: 0x80000000 >> 8 = 0x00800000 (logical, masked to 16-bit = 0x0000)
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x80000000; \
    li  x12, 8; \
    pnsrl.hs x8, x10, x12; \
  )

  # Shift by 31: 0x7fffffff >> 31 = 0x0000
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x7fffffff; \
    li  x12, 31; \
    pnsrl.hs x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

