# See LICENSE for license details.

#*****************************************************************************
# psrli_h.S
#-----------------------------------------------------------------------------
#
# Test psrli.h instruction (packed shift right logical immediate halfword).
# Operates on 32-bit register: rd = rs1 >> imm (imm in 0-15, logical)
# 2 elements of 16-bits each, logical shift right by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x80008000 >> 0 = 0x80008000
  TEST_CASE( 2, x14, 0x80008000, \
    li  x13, 0x80008000; \
    psrli.h x14, x13, 0; \
  )

  # Shift by 1: 0x80008000 >> 1 = 0x40004000 (logical, no sign extension)
  TEST_CASE( 3, x14, 0x40004000, \
    li  x13, 0x80008000; \
    psrli.h x14, x13, 1; \
  )

  # Shift by 2: 0x80008000 >> 2 = 0x20002000
  TEST_CASE( 4, x14, 0x20002000, \
    li  x13, 0x80008000; \
    psrli.h x14, x13, 2; \
  )

  # Shift by 4: 0x80008000 >> 4 = 0x08000800
  TEST_CASE( 5, x14, 0x08000800, \
    li  x13, 0x80008000; \
    psrli.h x14, x13, 4; \
  )

  # Shift by 8: 0x80008000 >> 8 = 0x00800080
  TEST_CASE( 6, x14, 0x00800080, \
    li  x13, 0x80008000; \
    psrli.h x14, x13, 8; \
  )

  # Shift by 15: 0x80008000 >> 15 = 0x00010001
  TEST_CASE( 7, x14, 0x00010001, \
    li  x13, 0x80008000; \
    psrli.h x14, x13, 15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

