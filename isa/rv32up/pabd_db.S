# See LICENSE for license details.

#*****************************************************************************
# pabd_db.S
#-----------------------------------------------------------------------------
#
# Test pabd.db instruction (packed signed absolute difference double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = |rs1:rs1+1 - rs2:rs2+1|
# 8 elements of 8-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |10 - 4| = 6
  TEST_CASE_D32( 2, x14, x15, 0x0606060606060606, \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x00000000; \
    li  x13, 0x04040404; \
    li  x16, 0x00000000; \
    pabd.db x14, x11, x13; \
  )

  # Negative difference: |4 - 10| = 6
  TEST_CASE_D32( 3, x14, x15, 0x0606060606060606, \
    li  x11, 0x04040404; \
    li  x12, 0x00000000; \
    li  x13, 0x0a0a0a0a; \
    li  x16, 0x00000000; \
    pabd.db x14, x11, x13; \
  )

  # Zero difference: |5 - 5| = 0
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x05050505; \
    li  x12, 0x00000000; \
    li  x13, 0x05050505; \
    li  x16, 0x00000000; \
    pabd.db x14, x11, x13; \
  )

  # Large values: |255 - 1| = 254
  TEST_CASE_D32( 5, x14, x15, 0xfefefefefefefefe, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x01010101; \
    li  x16, 0x00000000; \
    pabd.db x14, x11, x13; \
  )

  # Wrapping case: |100 - 200| = 100
  TEST_CASE_D32( 6, x14, x15, 0x6464646464646464, \
    li  x11, 0x64646464; \
    li  x12, 0x00000000; \
    li  x13, 0xc8c8c8c8; \
    li  x16, 0x00000000; \
    pabd.db x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

