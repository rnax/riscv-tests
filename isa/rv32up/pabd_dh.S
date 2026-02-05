# See LICENSE for license details.

#*****************************************************************************
# pabd_dh.S
#-----------------------------------------------------------------------------
#
# Test pabd.dh instruction (packed signed absolute difference double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = |rs1:rs1+1 - rs2:rs2+1|
# 4 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |1000 - 500| = 500
  TEST_CASE_D32( 2, x14, x15, 0x01f401f401f401f4, \
    li  x10, 0x03e803e8; \
    li  x11, 0x00000000; \
    li  x12, 0x01f401f4; \
    li  x13, 0x00000000; \
    pabd.dh x14, x10, x12; \
  )

  # Negative difference: |500 - 1000| = 500
  TEST_CASE_D32( 3, x14, x15, 0x01f401f401f401f4, \
    li  x10, 0x01f401f4; \
    li  x11, 0x00000000; \
    li  x12, 0x03e803e8; \
    li  x13, 0x00000000; \
    pabd.dh x14, x10, x12; \
  )

  # Zero difference: |100 - 100| = 0
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00640064; \
    li  x11, 0x00000000; \
    li  x12, 0x00640064; \
    li  x13, 0x00000000; \
    pabd.dh x14, x10, x12; \
  )

  # Max values: |32767 - 1| = 32766
  TEST_CASE_D32( 5, x14, x15, 0x7ffe7ffe7ffe7ffe, \
    li  x10, 0x7fff7fff; \
    li  x11, 0x00000000; \
    li  x12, 0x00010001; \
    li  x13, 0x00000000; \
    pabd.dh x14, x10, x12; \
  )

  # Negative values: |-100 - (-50)| = 50
  TEST_CASE_D32( 6, x14, x15, 0x00320032, \
    li  x10, 0xff9cff9c; \
    li  x11, 0xffffffff; \
    li  x12, 0xffceffce; \
    li  x13, 0xffffffff; \
    pabd.dh x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

