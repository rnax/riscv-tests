# See LICENSE for license details.

#*****************************************************************************
# psrl_bs.S
#-----------------------------------------------------------------------------
#
# Test psrl.bs instruction (packed shift right logical byte).
# Operates on 32-bit register: rd = rs1 >> (rs2 & 0x7) (logical)
# 4 elements of 8-bits each, logical shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x80808080 >> 0 = 0x80808080
  TEST_CASE( 2, x14, 0x80808080, \
    li  x13, 0x80808080; \
    li  x11, 0; \
    psrl.bs x14, x13, x11; \
  )

  # Shift by 1: 0x80808080 >> 1 = 0x40404040 (logical, no sign extension)
  TEST_CASE( 3, x14, 0x40404040, \
    li  x13, 0x80808080; \
    li  x11, 1; \
    psrl.bs x14, x13, x11; \
  )

  # Shift by 2: 0x80808080 >> 2 = 0x20202020
  TEST_CASE( 4, x14, 0x20202020, \
    li  x13, 0x80808080; \
    li  x11, 2; \
    psrl.bs x14, x13, x11; \
  )

  # Shift by 4: 0x80808080 >> 4 = 0x08080808
  TEST_CASE( 5, x14, 0x08080808, \
    li  x13, 0x80808080; \
    li  x11, 4; \
    psrl.bs x14, x13, x11; \
  )

  # Shift by 7: 0x80808080 >> 7 = 0x01010101
  TEST_CASE( 6, x14, 0x01010101, \
    li  x13, 0x80808080; \
    li  x11, 7; \
    psrl.bs x14, x13, x11; \
  )

  # Shift with all zeros: 0xffffffff >> 1 = 0x7f7f7f7f
  TEST_CASE( 7, x14, 0x7f7f7f7f, \
    li  x13, 0xffffffff; \
    li  x11, 1; \
    psrl.bs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

