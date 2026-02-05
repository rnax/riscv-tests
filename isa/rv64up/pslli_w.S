# See LICENSE for license details.

#*****************************************************************************
# pslli_w.S
#-----------------------------------------------------------------------------
#
# Test pslli.w instruction (packed shift left logical immediate word).
# Operates on 64-bit register: rd = rs1 << imm (imm in 0-31)
# 2 elements of 32-bits each, logical shift left by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0000000100000001 << 0 = 0x0000000100000001
  TEST_CASE( 2, x14, 0x0000000100000001, \
    li  x13, 0x0000000100000001; \
    pslli.w x14, x13, 0; \
  )

  # Shift by 1: 0x0000000100000001 << 1 = 0x0000000200000002
  TEST_CASE( 3, x14, 0x0000000200000002, \
    li  x13, 0x0000000100000001; \
    pslli.w x14, x13, 1; \
  )

  # Shift by 2: 0x0000000300000003 << 2 = 0x0000000c0000000c
  TEST_CASE( 4, x14, 0x0000000c0000000c, \
    li  x13, 0x0000000300000003; \
    pslli.w x14, x13, 2; \
  )

  # Shift by 4: 0x000000ff000000ff << 4 = 0x0000ff000000ff0
  TEST_CASE( 5, x14, 0x0000ff000000ff0, \
    li  x13, 0x000000ff000000ff; \
    pslli.w x14, x13, 4; \
  )

  # Shift by 8: 0x0000000100000001 << 8 = 0x0000010000000100
  TEST_CASE( 6, x14, 0x0000010000000100, \
    li  x13, 0x0000000100000001; \
    pslli.w x14, x13, 8; \
  )

  # Shift by 16: 0x0000000100000001 << 16 = 0x0001000000010000
  TEST_CASE( 7, x14, 0x0001000000010000, \
    li  x13, 0x0000000100000001; \
    pslli.w x14, x13, 16; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

