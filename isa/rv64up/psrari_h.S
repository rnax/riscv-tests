# See LICENSE for license details.

#*****************************************************************************
# psrari_h.S
#-----------------------------------------------------------------------------
#
# Test psrari.h instruction (packed shift right arithmetic with rounding immediate halfword).
# Operates on 32-bit register: rd = (rs1 >> imm) + rounding (imm in 0-15)
# 2 elements of 16-bits each, arithmetic shift right with rounding by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x80008000 >> 0 = 0x80008000 (no rounding)
  TEST_CASE( 2, x14, 0x80008000, \
    li  x13, 0x80008000; \
    psrari.h x14, x13, 0; \
  )

  # Shift by 1 with rounding: 0x80008000 >> 1 + round = 0xc001c001
  TEST_CASE( 3, x14, 0xc001c001, \
    li  x13, 0x80008000; \
    psrari.h x14, x13, 1; \
  )

  # Shift by 2 with rounding: 0x80008000 >> 2 + round = 0xe000e000
  TEST_CASE( 4, x14, 0xe000e000, \
    li  x13, 0x80008000; \
    psrari.h x14, x13, 2; \
  )

  # Shift by 4 with rounding: 0x80008000 >> 4 + round = 0xf800f800
  TEST_CASE( 5, x14, 0xf800f800, \
    li  x13, 0x80008000; \
    psrari.h x14, x13, 4; \
  )

  # Positive value: 0x7fff7fff >> 1 + round = 0x4000 4000
  TEST_CASE( 6, x14, 0x40004000, \
    li  x13, 0x7fff7fff; \
    psrari.h x14, x13, 1; \
  )

  # Shift by 15 with rounding: 0x80008000 >> 15 + round = 0xffffffff
  TEST_CASE( 7, x14, 0xffffffff, \
    li  x13, 0x80008000; \
    psrari.h x14, x13, 15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

