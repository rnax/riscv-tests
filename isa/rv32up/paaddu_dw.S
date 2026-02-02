# See LICENSE for license details.

#*****************************************************************************
# paaddu_dw.S
#-----------------------------------------------------------------------------
#
# Test paaddu.dw instruction (packed unsigned averaging add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 + rs2:rs2+1) >> 1
# 2 elements of 32-bits each, unsigned averaging add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (1000000 + 2000000) >> 1 = 1500000 for each word
  TEST_CASE_D32( 2, x14, x15, 0x0016e3600016e360, \
    li  x11, 0x000f4240; \
    li  x12, 0x00000000; \
    li  x13, 0x001e8480; \
    li  x16, 0x00000000; \
    paaddu.dw x14, x11, x13; \
  )

  # Odd sum truncation: (0xffffffff + 0xfffffffe) >> 1 = 0xfffffffe
  TEST_CASE_D32( 3, x14, x15, 0xfffffffefffffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0xfffffffe; \
    li  x16, 0x00000000; \
    paaddu.dw x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    paaddu.dw x14, x11, x13; \
  )

  # Large values: (0xffffffff + 0xffffffff) >> 1 = 0xffffffff
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0xffffffff; \
    li  x16, 0x00000000; \
    paaddu.dw x14, x11, x13; \
  )

  # Mixed values: (500000 + 1000000) >> 1 = 750000
  TEST_CASE_D32( 6, x14, x15, 0x000b71b0000b71b0, \
    li  x11, 0x0007a120; \
    li  x12, 0x00000000; \
    li  x13, 0x000f4240; \
    li  x16, 0x00000000; \
    paaddu.dw x14, x11, x13; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x000f42400007a120, \
    li  x10, 0x0007a120; \
    li  x11, 0x00000000; \
    li  x12, 0x000f4240; \
    li  x13, 0x00000000; \
    paaddu.dw x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

