# See LICENSE for license details.

#*****************************************************************************
# pslli_dw.S
#-----------------------------------------------------------------------------
#
# Test pslli.dw instruction (packed shift left logical immediate double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) << imm (imm in 0-31)
# 2 elements of 32-bits each, logical shift left by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0000000100000001 << 0 = 0x0000000100000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000100000001, \
    li  x11, 0x00000001; \
    li  x12, 0x00000000; \
    pslli.dw x14, x11, 0; \
  )

  # Shift by 1: 0x0000000100000001 << 1 = 0x0000000200000002
  TEST_CASE_D32( 3, x14, x15, 0x0000000200000002, \
    li  x11, 0x00000001; \
    li  x12, 0x00000000; \
    pslli.dw x14, x11, 1; \
  )

  # Shift by 8: 0x00000fff00000fff << 8 = 0x0fff000000fff0000
  TEST_CASE_D32( 4, x14, x15, 0x0fff000000fff0000, \
    li  x11, 0x00000fff; \
    li  x12, 0x00000000; \
    pslli.dw x14, x11, 8; \
  )

  # Shift by 16: 0x0000ffff0000ffff << 16 = 0xffff000000000000
  TEST_CASE_D32( 5, x14, x15, 0xffff000000000000, \
    li  x11, 0x0000ffff; \
    li  x12, 0x00000000; \
    pslli.dw x14, x11, 16; \
  )

  # Shift by 31: 0x0000000100000001 << 31 = 0x8000000080000000
  TEST_CASE_D32( 6, x14, x15, 0x8000000080000000, \
    li  x11, 0x00000001; \
    li  x12, 0x00000000; \
    pslli.dw x14, x11, 31; \
  )

  # Shift with overflow: 0xffffffffffffffff << 1 = 0xfffffffffffffffe
  TEST_CASE_D32( 7, x14, x15, 0xfffffffffffffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    pslli.dw x14, x11, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

