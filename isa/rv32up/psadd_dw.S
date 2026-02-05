# See LICENSE for license details.

#*****************************************************************************
# psadd_dw.S
#-----------------------------------------------------------------------------
#
# Test psadd.dw instruction (packed saturating add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 + rs2:rs2+1)
# 2 elements of 32-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100 + 200 = 300
  TEST_CASE_D32( 2, x14, x15, 0x0000012c0000012c, \
    li  x10, 0x00000064; \
    li  x11, 0x00000064; \
    li  x12, 0x000000c8; \
    li  x13, 0x000000c8; \
    psadd.dw x14, x10, x12; \
  )

  # Saturation at max positive: 0x40000000 + 0x40000000 saturates to 0x7FFFFFFF
  TEST_CASE_D32( 3, x14, x15, 0x7fffffff7fffffff, \
    li  x10, 0x40000000; \
    li  x11, 0x40000000; \
    li  x12, 0x40000000; \
    li  x13, 0x40000000; \
    psadd.dw x14, x10, x12; \
  )

  # Saturation at min negative: 0xC0000000 + 0xC0000000 saturates to 0x80000000
  TEST_CASE_D32( 4, x14, x15, 0x8000000080000000, \
    li  x10, 0xc0000000; \
    li  x11, 0xc0000000; \
    li  x12, 0xc0000000; \
    li  x13, 0xc0000000; \
    psadd.dw x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    psadd.dw x14, x10, x12; \
  )

  # Mixed values: 1000 + 500 = 1500
  TEST_CASE_D32( 6, x14, x15, 0x000005dc000005dc, \
    li  x10, 0x000003e8; \
    li  x11, 0x000003e8; \
    li  x12, 0x000001f4; \
    li  x13, 0x000001f4; \
    psadd.dw x14, x10, x12; \
  )

  # Negative operands: -1000 + -500 = -1500
  TEST_CASE_D32( 7, x14, x15, 0xfffffa24fffffa24, \
    li  x10, 0xfffffc18; \
    li  x11, 0xfffffc18; \
    li  x12, 0xfffffe0c; \
    li  x13, 0xfffffe0c; \
    psadd.dw x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

