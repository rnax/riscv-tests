# See LICENSE for license details.

#*****************************************************************************
# psslai_w.S
#-----------------------------------------------------------------------------
#
# Test psslai.w instruction (packed saturating shift left arithmetic immediate word).
# Operates on 64-bit register: rd = saturate(rs1 << imm) (imm in 0-31)
# 2 elements of 32-bits each, saturating shift left arithmetic by immediate
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
    psslai.w x14, x13, 0; \
  )

  # Shift by 1: 0x0000000100000001 << 1 = 0x0000000200000002
  TEST_CASE( 3, x14, 0x0000000200000002, \
    li  x13, 0x0000000100000001; \
    psslai.w x14, x13, 1; \
  )

  # Shift by 4: 0x0000000100000001 << 4 = 0x0000001000000010
  TEST_CASE( 4, x14, 0x0000001000000010, \
    li  x13, 0x0000000100000001; \
    psslai.w x14, x13, 4; \
  )

  # Saturate positive: 0x4000000040000000 << 1 = 0x7fffffff7fffffff (saturated)
  TEST_CASE( 5, x14, 0x7fffffff7fffffff, \
    li  x13, 0x4000000040000000; \
    psslai.w x14, x13, 1; \
  )

  # Saturate negative: 0x8000000080000000 << 1 = 0x8000000080000000 (saturated)
  TEST_CASE( 6, x14, 0x8000000080000000, \
    li  x13, 0x8000000080000000; \
    psslai.w x14, x13, 1; \
  )

  # Shift by 16: 0x0000000100000001 << 16 = 0x0001000000010000
  TEST_CASE( 7, x14, 0x0001000000010000, \
    li  x13, 0x0000000100000001; \
    psslai.w x14, x13, 16; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

