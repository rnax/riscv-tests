# See LICENSE for license details.

#*****************************************************************************
# pabdu_dh.S
#-----------------------------------------------------------------------------
#
# Test pabdu.dh instruction (packed unsigned absolute difference double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = |rs1:rs1+1 - rs2:rs2+1| (unsigned)
# 4 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |2000 - 1000| = 1000
  TEST_CASE_D32( 2, x14, x15, 0x03e803e803e803e8, \
    li  x11, 0x07d007d0; \
    li  x12, 0x00000000; \
    li  x13, 0x03e803e8; \
    li  x16, 0x00000000; \
    pabdu.dh x14, x11, x13; \
  )

  # Reverse difference: |1000 - 2000| = 1000
  TEST_CASE_D32( 3, x14, x15, 0x03e803e803e803e8, \
    li  x11, 0x03e803e8; \
    li  x12, 0x00000000; \
    li  x13, 0x07d007d0; \
    li  x16, 0x00000000; \
    pabdu.dh x14, x11, x13; \
  )

  # Zero difference: |500 - 500| = 0
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x01f401f4; \
    li  x12, 0x00000000; \
    li  x13, 0x01f401f4; \
    li  x16, 0x00000000; \
    pabdu.dh x14, x11, x13; \
  )

  # Max values: |65535 - 0| = 65535
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pabdu.dh x14, x11, x13; \
  )

  # Large difference: |65535 - 1| = 65534
  TEST_CASE_D32( 6, x14, x15, 0xfffefffefffeffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x00010001; \
    li  x16, 0x00000000; \
    pabdu.dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

