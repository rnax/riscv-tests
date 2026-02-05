# See LICENSE for license details.

#*****************************************************************************
# psll_bs.S
#-----------------------------------------------------------------------------
#
# Test psll.bs instruction (packed shift left logical byte).
# Operates on 32-bit register: rd = rs1 << (rs2 & 0x7)
# 4 elements of 8-bits each, logical shift left
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x01010101 << 0 = 0x01010101
  TEST_CASE( 2, x14, 0x01010101, \
    li  x13, 0x01010101; \
    li  x11, 0; \
    psll.bs x14, x13, x11; \
  )

  # Shift by 1: 0x01010101 << 1 = 0x02020202
  TEST_CASE( 3, x14, 0x02020202, \
    li  x13, 0x01010101; \
    li  x11, 1; \
    psll.bs x14, x13, x11; \
  )

  # Shift by 2: 0x03030303 << 2 = 0x0c0c0c0c
  TEST_CASE( 4, x14, 0x0c0c0c0c, \
    li  x13, 0x03030303; \
    li  x11, 2; \
    psll.bs x14, x13, x11; \
  )

  # Shift by 4: 0x0f0f0f0f << 4 = 0xf0f0f0f0
  TEST_CASE( 5, x14, 0xf0f0f0f0, \
    li  x13, 0x0f0f0f0f; \
    li  x11, 4; \
    psll.bs x14, x13, x11; \
  )

  # Shift by 7: 0x01010101 << 7 = 0x80808080
  TEST_CASE( 6, x14, 0x80808080, \
    li  x13, 0x01010101; \
    li  x11, 7; \
    psll.bs x14, x13, x11; \
  )

  # Shift with overflow: 0xffffffff << 1 = 0xfffffffe
  TEST_CASE( 7, x14, 0xfffffffe, \
    li  x13, 0xffffffff; \
    li  x11, 1; \
    psll.bs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

