# See LICENSE for license details.

#*****************************************************************************
# pslli_db.S
#-----------------------------------------------------------------------------
#
# Test pslli.db instruction (packed shift left logical immediate double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) << imm (imm in 0-7)
# 8 elements of 8-bits each, logical shift left by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0101010101010101 << 0 = 0x0101010101010101
  TEST_CASE_D32( 2, x14, x15, 0x0101010101010101, \
    li  x11, 0x01010101; \
    li  x12, 0x00000000; \
    pslli.db x14, x11, 0; \
  )

  # Shift by 1: 0x0101010101010101 << 1 = 0x0202020202020202
  TEST_CASE_D32( 3, x14, x15, 0x0202020202020202, \
    li  x11, 0x01010101; \
    li  x12, 0x00000000; \
    pslli.db x14, x11, 1; \
  )

  # Shift by 2: 0x0303030303030303 << 2 = 0x0c0c0c0c0c0c0c0c
  TEST_CASE_D32( 4, x14, x15, 0x0c0c0c0c0c0c0c0c, \
    li  x11, 0x03030303; \
    li  x12, 0x00000000; \
    pslli.db x14, x11, 2; \
  )

  # Shift by 4: 0x0f0f0f0f0f0f0f0f << 4 = 0xf0f0f0f0f0f0f0f0
  TEST_CASE_D32( 5, x14, x15, 0xf0f0f0f0f0f0f0f0, \
    li  x11, 0x0f0f0f0f; \
    li  x12, 0x00000000; \
    pslli.db x14, x11, 4; \
  )

  # Shift by 7: 0x0101010101010101 << 7 = 0x8080808080808080
  TEST_CASE_D32( 6, x14, x15, 0x8080808080808080, \
    li  x11, 0x01010101; \
    li  x12, 0x00000000; \
    pslli.db x14, x11, 7; \
  )

  # Shift with overflow: 0xffffffffffffffff << 1 = 0xfffffffffffffffe
  TEST_CASE_D32( 7, x14, x15, 0xfffffffffffffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    pslli.db x14, x11, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

