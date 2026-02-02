# See LICENSE for license details.

#*****************************************************************************
# pabdu_db.S
#-----------------------------------------------------------------------------
#
# Test pabdu.db instruction (packed unsigned absolute difference double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = |rs1:rs1+1 - rs2:rs2+1| (unsigned)
# 8 elements of 8-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |200 - 100| = 100
  TEST_CASE_D32( 2, x14, x15, 0x6464646464646464, \
    li  x11, 0xc8c8c8c8; \
    li  x12, 0x00000000; \
    li  x13, 0x64646464; \
    li  x16, 0x00000000; \
    pabdu.db x14, x11, x13; \
  )

  # Reverse difference: |100 - 200| = 100
  TEST_CASE_D32( 3, x14, x15, 0x6464646464646464, \
    li  x11, 0x64646464; \
    li  x12, 0x00000000; \
    li  x13, 0xc8c8c8c8; \
    li  x16, 0x00000000; \
    pabdu.db x14, x11, x13; \
  )

  # Zero difference: |150 - 150| = 0
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x96969696; \
    li  x12, 0x00000000; \
    li  x13, 0x96969696; \
    li  x16, 0x00000000; \
    pabdu.db x14, x11, x13; \
  )

  # Max values: |255 - 0| = 255
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pabdu.db x14, x11, x13; \
  )

  # Large difference: |255 - 1| = 254
  TEST_CASE_D32( 6, x14, x15, 0xfefefefefefefefe, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x01010101; \
    li  x16, 0x00000000; \
    pabdu.db x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

