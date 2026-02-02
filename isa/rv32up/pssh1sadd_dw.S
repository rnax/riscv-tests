# See LICENSE for license details.

#*****************************************************************************
# pssh1sadd_dw.S
#-----------------------------------------------------------------------------
#
# Test pssh1sadd.dw instruction (packed saturating shift left 1 and add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = SAT((rs1:rs1+1 << 1) + rs2:rs2+1)
# 2 elements of 32-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: ((2 << 1) + 3) = 7
  TEST_CASE_D32( 2, x14, x15, 0x0000000700000007, \
    li  x11, 0x00000002; \
    li  x12, 0x00000002; \
    li  x13, 0x00000003; \
    li  x16, 0x00000003; \
    pssh1sadd.dw x14, x11, x13; \
  )

  # ((5 << 1) + 10) = 20
  TEST_CASE_D32( 3, x14, x15, 0x0000001400000014, \
    li  x11, 0x00000005; \
    li  x12, 0x00000005; \
    li  x13, 0x0000000a; \
    li  x16, 0x0000000a; \
    pssh1sadd.dw x14, x11, x13; \
  )

  # Saturation: ((0x40000000 << 1) + 0x40000000) saturates to 0x7FFFFFFF
  TEST_CASE_D32( 4, x14, x15, 0x7fffffff7fffffff, \
    li  x11, 0x40000000; \
    li  x12, 0x40000000; \
    li  x13, 0x40000000; \
    li  x16, 0x40000000; \
    pssh1sadd.dw x14, x11, x13; \
  )

  # Saturation: ((0xC0000000 << 1) + 0xC0000000) saturates to 0x80000000
  TEST_CASE_D32( 5, x14, x15, 0x8000000080000000, \
    li  x11, 0xc0000000; \
    li  x12, 0xc0000000; \
    li  x13, 0xc0000000; \
    li  x16, 0xc0000000; \
    pssh1sadd.dw x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pssh1sadd.dw x14, x11, x13; \
  )

  # ((100 << 1) + 50) = 250
  TEST_CASE_D32( 7, x14, x15, 0x000000fa000000fa, \
    li  x11, 0x00000064; \
    li  x12, 0x00000064; \
    li  x13, 0x00000032; \
    li  x16, 0x00000032; \
    pssh1sadd.dw x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

