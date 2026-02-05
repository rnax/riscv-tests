# See LICENSE for license details.

#*****************************************************************************
# psslai_h.S
#-----------------------------------------------------------------------------
#
# Test psslai.h instruction (packed saturating shift left arithmetic immediate halfword).
# Operates on 32-bit register: rd = saturate(rs1 << imm) (imm in 0-15)
# 2 elements of 16-bits each, saturating shift left arithmetic by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x00010001 << 0 = 0x00010001
  TEST_CASE( 2, x14, 0x00010001, \
    li  x13, 0x00010001; \
    psslai.h x14, x13, 0; \
  )

  # Shift by 1: 0x00010001 << 1 = 0x00020002
  TEST_CASE( 3, x14, 0x00020002, \
    li  x13, 0x00010001; \
    psslai.h x14, x13, 1; \
  )

  # Shift by 4: 0x00010001 << 4 = 0x00100010
  TEST_CASE( 4, x14, 0x00100010, \
    li  x13, 0x00010001; \
    psslai.h x14, x13, 4; \
  )

  # Saturate positive: 0x40004000 << 1 = 0x7fff7fff (saturated)
  TEST_CASE( 5, x14, 0x7fff7fff, \
    li  x13, 0x40004000; \
    psslai.h x14, x13, 1; \
  )

  # Saturate negative: 0x80008000 << 1 = 0x80008000 (saturated)
  TEST_CASE( 6, x14, 0x80008000, \
    li  x13, 0x80008000; \
    psslai.h x14, x13, 1; \
  )

  # Shift by 15: 0x00010001 << 15 = 0x80008000
  TEST_CASE( 7, x14, 0x80008000, \
    li  x13, 0x00010001; \
    psslai.h x14, x13, 15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

