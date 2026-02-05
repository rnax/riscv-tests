# See LICENSE for license details.

#*****************************************************************************
# pslli_h.S
#-----------------------------------------------------------------------------
#
# Test pslli.h instruction (packed shift left logical immediate halfword).
# Operates on 32-bit register: rd = rs1 << imm (imm in 0-15)
# 2 elements of 16-bits each, logical shift left by immediate
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
    pslli.h x14, x13, 0; \
  )

  # Shift by 1: 0x00010001 << 1 = 0x00020002
  TEST_CASE( 3, x14, 0x00020002, \
    li  x13, 0x00010001; \
    pslli.h x14, x13, 1; \
  )

  # Shift by 2: 0x00030003 << 2 = 0x000c000c
  TEST_CASE( 4, x14, 0x000c000c, \
    li  x13, 0x00030003; \
    pslli.h x14, x13, 2; \
  )

  # Shift by 4: 0x000f000f << 4 = 0x00f000f0
  TEST_CASE( 5, x14, 0x00f000f0, \
    li  x13, 0x000f000f; \
    pslli.h x14, x13, 4; \
  )

  # Shift by 8: 0x00010001 << 8 = 0x01000100
  TEST_CASE( 6, x14, 0x01000100, \
    li  x13, 0x00010001; \
    pslli.h x14, x13, 8; \
  )

  # Shift by 15: 0x00010001 << 15 = 0x80008000
  TEST_CASE( 7, x14, 0x80008000, \
    li  x13, 0x00010001; \
    pslli.h x14, x13, 15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

