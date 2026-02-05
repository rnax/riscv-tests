# See LICENSE for license details.

#*****************************************************************************
# psrli_b.S
#-----------------------------------------------------------------------------
#
# Test psrli.b instruction (packed shift right logical immediate byte).
# Operates on 32-bit register: rd = rs1 >> imm (imm in 0-7, logical)
# 4 elements of 8-bits each, logical shift right by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x80808080 >> 0 = 0x80808080
  TEST_CASE( 2, x14, 0x80808080, \
    li  x13, 0x80808080; \
    psrli.b x14, x13, 0; \
  )

  # Shift by 1: 0x80808080 >> 1 = 0x40404040 (logical, no sign extension)
  TEST_CASE( 3, x14, 0x40404040, \
    li  x13, 0x80808080; \
    psrli.b x14, x13, 1; \
  )

  # Shift by 2: 0x80808080 >> 2 = 0x20202020
  TEST_CASE( 4, x14, 0x20202020, \
    li  x13, 0x80808080; \
    psrli.b x14, x13, 2; \
  )

  # Shift by 4: 0x80808080 >> 4 = 0x08080808
  TEST_CASE( 5, x14, 0x08080808, \
    li  x13, 0x80808080; \
    psrli.b x14, x13, 4; \
  )

  # Shift by 7: 0x80808080 >> 7 = 0x01010101
  TEST_CASE( 6, x14, 0x01010101, \
    li  x13, 0x80808080; \
    psrli.b x14, x13, 7; \
  )

  # Shift with all ones: 0xffffffff >> 1 = 0x7f7f7f7f
  TEST_CASE( 7, x14, 0x7f7f7f7f, \
    li  x13, 0xffffffff; \
    psrli.b x14, x13, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

