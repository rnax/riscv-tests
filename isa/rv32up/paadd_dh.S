# See LICENSE for license details.

#*****************************************************************************
# paadd_dh.S
#-----------------------------------------------------------------------------
#
# Test paadd.dh instruction (packed averaging add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 + rs2:rs2+1) >> 1
# 4 elements of 16-bits each, signed averaging add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (100 + 200) >> 1 = 150 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x0096009600960096, \
    li  x10, 0x00640064; \
    li  x11, 0x00000000; \
    li  x12, 0x00c800c8; \
    li  x13, 0x00000000; \
    paadd.dh x14, x10, x12; \
  )

  # Odd sum truncation: (3 + 4) >> 1 = 3 for each halfword
  TEST_CASE_D32( 3, x14, x15, 0x0003000300030003, \
    li  x10, 0x00030003; \
    li  x11, 0x00000000; \
    li  x12, 0x00040004; \
    li  x13, 0x00000000; \
    paadd.dh x14, x10, x12; \
  )

  # Negative numbers: (-100 + 200) >> 1 = 50 for each halfword
  TEST_CASE_D32( 4, x14, x15, 0x0032003200320032, \
    li  x10, 0xff9cff9c; \
    li  x11, 0xffffffff; \
    li  x12, 0x00c800c8; \
    li  x13, 0x00000000; \
    paadd.dh x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    paadd.dh x14, x10, x12; \
  )

  # Large positive values: (32767 + 32767) >> 1 = 32767
  TEST_CASE_D32( 6, x14, x15, 0x7fff7fff7fff7fff, \
    li  x10, 0x7fff7fff; \
    li  x11, 0x00000000; \
    li  x12, 0x7fff7fff; \
    li  x13, 0x00000000; \
    paadd.dh x14, x10, x12; \
  )

  # Mixed values across register pair
  TEST_CASE_D32( 7, x10, x11, 0x00640064003c003c, \
    li  x10, 0x00500050; \
    li  x10, 0x00000000; \
    li  x11, 0x00780078; \
    li  x12, 0x00000000; \
    paadd.dh x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

