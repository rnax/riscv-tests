# See LICENSE for license details.

#*****************************************************************************
# pslli_dh.S
#-----------------------------------------------------------------------------
#
# Test pslli.dh instruction (packed shift left logical immediate double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) << imm (imm in 0-15)
# 4 elements of 16-bits each, logical shift left by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0001000100010001 << 0 = 0x0001000100010001
  TEST_CASE_D32( 2, x14, x15, 0x0001000100010001, \
    li  x11, 0x00010001; \
    li  x12, 0x00000000; \
    pslli.dh x14, x11, 0; \
  )

  # Shift by 1: 0x0001000100010001 << 1 = 0x0002000200020002
  TEST_CASE_D32( 3, x14, x15, 0x0002000200020002, \
    li  x11, 0x00010001; \
    li  x12, 0x00000000; \
    pslli.dh x14, x11, 1; \
  )

  # Shift by 4: 0x0fff0fff0fff0fff << 4 = 0xfff0fff0fff0fff0
  TEST_CASE_D32( 4, x14, x15, 0xfff0fff0fff0fff0, \
    li  x11, 0x0fff0fff; \
    li  x12, 0x00000000; \
    pslli.dh x14, x11, 4; \
  )

  # Shift by 8: 0x00ff00ff00ff00ff << 8 = 0xff00ff00ff00ff00
  TEST_CASE_D32( 5, x14, x15, 0xff00ff00ff00ff00, \
    li  x11, 0x00ff00ff; \
    li  x12, 0x00000000; \
    pslli.dh x14, x11, 8; \
  )

  # Shift by 15: 0x0001000100010001 << 15 = 0x8000800080008000
  TEST_CASE_D32( 6, x14, x15, 0x8000800080008000, \
    li  x11, 0x00010001; \
    li  x12, 0x00000000; \
    pslli.dh x14, x11, 15; \
  )

  # Shift with overflow: 0xffffffffffffffff << 1 = 0xfffffffffffffffe
  TEST_CASE_D32( 7, x14, x15, 0xfffffffffffffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    pslli.dh x14, x11, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

