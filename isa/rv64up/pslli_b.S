# See LICENSE for license details.

#*****************************************************************************
# pslli_b.S
#-----------------------------------------------------------------------------
#
# Test pslli.b instruction (packed shift left logical immediate byte).
# Operates on 32-bit register: rd = rs1 << imm (imm in 0-7)
# 4 elements of 8-bits each, logical shift left by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x01010101 << 0 = 0x01010101
  TEST_CASE( 2, x14, 0x01010101, \
    li  x13, 0x01010101; \
    pslli.b x14, x13, 0; \
  )

  # Shift by 1: 0x01010101 << 1 = 0x02020202
  TEST_CASE( 3, x14, 0x02020202, \
    li  x13, 0x01010101; \
    pslli.b x14, x13, 1; \
  )

  # Shift by 2: 0x03030303 << 2 = 0x0c0c0c0c
  TEST_CASE( 4, x14, 0x0c0c0c0c, \
    li  x13, 0x03030303; \
    pslli.b x14, x13, 2; \
  )

  # Shift by 4: 0x0f0f0f0f << 4 = 0xf0f0f0f0
  TEST_CASE( 5, x14, 0xf0f0f0f0, \
    li  x13, 0x0f0f0f0f; \
    pslli.b x14, x13, 4; \
  )

  # Shift by 7: 0x01010101 << 7 = 0x80808080
  TEST_CASE( 6, x14, 0x80808080, \
    li  x13, 0x01010101; \
    pslli.b x14, x13, 7; \
  )

  # Shift with overflow: 0xffffffff << 1 = 0xfffffffe
  TEST_CASE( 7, x14, 0xfffffffe, \
    li  x13, 0xffffffff; \
    pslli.b x14, x13, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

