# See LICENSE for license details.

#*****************************************************************************
# paadd_dw.S
#-----------------------------------------------------------------------------
#
# Test paadd.dw instruction (packed averaging add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 + rs2:rs2+1) >> 1
# 2 elements of 32-bits each, signed averaging add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (1000 + 2000) >> 1 = 1500 for each word
  TEST_CASE_D32( 2, x14, x15, 0x000005dc000005dc, \
    li  x11, 0x000003e8; \
    li  x12, 0x00000000; \
    li  x13, 0x000007d0; \
    li  x16, 0x00000000; \
    paadd.dw x14, x11, x13; \
  )

  # Odd sum truncation: (3 + 4) >> 1 = 3 for each word
  TEST_CASE_D32( 3, x14, x15, 0x0000000300000003, \
    li  x11, 0x00000003; \
    li  x12, 0x00000000; \
    li  x13, 0x00000004; \
    li  x16, 0x00000000; \
    paadd.dw x14, x11, x13; \
  )

  # Negative numbers: (-1000 + 2000) >> 1 = 500 for each word
  TEST_CASE_D32( 4, x14, x15, 0x000001f4000001f4, \
    li  x11, 0xfffffc18; \
    li  x12, 0xffffffff; \
    li  x13, 0x000007d0; \
    li  x16, 0x00000000; \
    paadd.dw x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    paadd.dw x14, x11, x13; \
  )

  # Large positive values: (0x7fffffff + 0x7fffffff) >> 1 = 0x7fffffff
  TEST_CASE_D32( 6, x14, x15, 0x7fffffff7fffffff, \
    li  x11, 0x7fffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x7fffffff; \
    li  x16, 0x00000000; \
    paadd.dw x14, x11, x13; \
  )

  # Mixed values across register pair
  TEST_CASE_D32( 7, x10, x11, 0x00000064000003e8, \
    li  x10, 0x000003e8; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    paadd.dw x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

