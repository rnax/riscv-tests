# See LICENSE for license details.

#*****************************************************************************
# padd_dw.S
#-----------------------------------------------------------------------------
#
# Test padd.dw instruction (packed add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 + rs2:rs2+1
# 2 elements of 32-bits each, wrapping add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 1000 + 2000 = 3000 for each word
  TEST_CASE_D32( 2, x14, x15, 0x00000bb800000bb8, \
    li  x11, 0x000003e8; \
    li  x12, 0x00000000; \
    li  x13, 0x000007d0; \
    li  x16, 0x00000000; \
    padd.dw x14, x11, x13; \
  )

  # Wrapping add: 0x80000000 + 0x80000000 = 0x100000000 (wraps to 0)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x11, 0x80000000; \
    li  x12, 0x00000000; \
    li  x13, 0x80000000; \
    li  x16, 0x00000000; \
    padd.dw x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    padd.dw x14, x11, x13; \
  )

  # Large values: 0xffffffff + 1 = 0x100000000 (wraps to 0)
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    padd.dw x14, x11, x13; \
  )

  # Mixed values: 1000000 + 500000 = 1500000
  TEST_CASE_D32( 6, x14, x15, 0x0016e3600016e360, \
    li  x11, 0x000f4240; \
    li  x12, 0x00000000; \
    li  x13, 0x0007a120; \
    li  x16, 0x00000000; \
    padd.dw x14, x11, x13; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x00000bb800000bb8, \
    li  x10, 0x000003e8; \
    li  x11, 0x00000000; \
    li  x12, 0x000007d0; \
    li  x13, 0x00000000; \
    padd.dw x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

