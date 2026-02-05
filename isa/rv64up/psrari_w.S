# See LICENSE for license details.

#*****************************************************************************
# psrari_w.S
#-----------------------------------------------------------------------------
#
# Test psrari.w instruction (packed shift right arithmetic with rounding immediate word).
# Operates on 64-bit register: rd = (rs1 >> imm) + rounding (imm in 0-31)
# 2 elements of 32-bits each, arithmetic shift right with rounding by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x8000000080000000 >> 0 = 0x8000000080000000 (no rounding)
  TEST_CASE( 2, x14, 0x8000000080000000, \
    li  x13, 0x8000000080000000; \
    psrari.w x14, x13, 0; \
  )

  # Shift by 1 with rounding: 0x8000000080000000 >> 1 + round = 0xc000000c0000001
  TEST_CASE( 3, x14, 0xc000000c0000001, \
    li  x13, 0x8000000080000000; \
    psrari.w x14, x13, 1; \
  )

  # Shift by 2 with rounding: 0x8000000080000000 >> 2 + round = 0xe000000e0000000
  TEST_CASE( 4, x14, 0xe000000e0000000, \
    li  x13, 0x8000000080000000; \
    psrari.w x14, x13, 2; \
  )

  # Shift by 4 with rounding: 0x8000000080000000 >> 4 + round = 0xf800000f8000000
  TEST_CASE( 5, x14, 0xf800000f8000000, \
    li  x13, 0x8000000080000000; \
    psrari.w x14, x13, 4; \
  )

  # Positive value: 0x7fffffff7fffffff >> 1 + round = 0x4000000040000000
  TEST_CASE( 6, x14, 0x4000000040000000, \
    li  x13, 0x7fffffff7fffffff; \
    psrari.w x14, x13, 1; \
  )

  # Shift by 16 with rounding: 0x8000000080000000 >> 16 + round = 0xffff8000ffff8000
  TEST_CASE( 7, x14, 0xffff8000ffff8000, \
    li  x13, 0x8000000080000000; \
    psrari.w x14, x13, 16; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

