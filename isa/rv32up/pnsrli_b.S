# See LICENSE for license details.

#*****************************************************************************
# pnsrli_b.S
#-----------------------------------------------------------------------------
#
# Test pnsrli.b instruction (packed narrowing shift right logical immediate byte).
# Narrows 16-bit values to 8-bit (unsigned) with immediate shift: rd = (uint16_t)(rs1) >> shamt
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
    pnsrli.b x8, x10, 0; \
  )

  # Shift by 1: 0x0010 >> 1 = 0x08
  TEST_CASE_D32( 3, x10, x11, 0x00000008, \
    li  x10, 0x00000010; \
    pnsrli.b x8, x10, 1; \
  )

  # Shift by 4: 0x00f0 >> 4 = 0x0f
  TEST_CASE_D32( 4, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    pnsrli.b x8, x10, 4; \
  )

  # Unsigned: 0xff00 >> 1 = 0x7f80 (logical, not sign extended, masked to 8-bit = 0x80)
  TEST_CASE_D32( 5, x10, x11, 0x00000080, \
    li  x10, 0x0000ff00; \
    pnsrli.b x8, x10, 1; \
  )

  # Unsigned: 0x8000 >> 4 = 0x0800 (logical, masked to 8-bit = 0x00)
  TEST_CASE_D32( 6, x10, x11, 0x00000000, \
    li  x10, 0x00008000; \
    pnsrli.b x8, x10, 4; \
  )

  # Shift by 15: 0x7fff >> 15 = 0x0000
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00007fff; \
    pnsrli.b x8, x10, 15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

