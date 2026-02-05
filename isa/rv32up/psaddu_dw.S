# See LICENSE for license details.

#*****************************************************************************
# psaddu_dw.S
#-----------------------------------------------------------------------------
#
# Test psaddu.dw instruction (packed unsigned saturating add double-word).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 + rs2:rs2+1)
# 2 elements of 32-bits each, unsigned with saturation
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
    psaddu.dw x14, x10, x12; \
  )

  # Saturation at max unsigned: 0x80000000 + 0x80000000 saturates to 0xFFFFFFFF
  TEST_CASE_D32( 3, x14, x15, 0xffffffffffffffffL, \
    li  x10, 0x80000000; \
    li  x11, 0x80000000; \
    li  x12, 0x80000000; \
    li  x13, 0x80000000; \
    psaddu.dw x14, x10, x12; \
  )

  # No saturation: 0x40000000 + 0x40000000 = 0x80000000
  TEST_CASE_D32( 4, x14, x15, 0x8000000080000000, \
    li  x10, 0x40000000; \
    li  x11, 0x40000000; \
    li  x12, 0x40000000; \
    li  x13, 0x40000000; \
    psaddu.dw x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    psaddu.dw x14, x10, x12; \
  )

  # Mixed values: 1000 + 500 = 1500
  TEST_CASE_D32( 6, x14, x15, 0x000005dc000005dc, \
    li  x10, 0x000003e8; \
    li  x11, 0x000003e8; \
    li  x12, 0x000001f4; \
    li  x13, 0x000001f4; \
    psaddu.dw x14, x10, x12; \
  )

  # Large values: 0xFFFFFFFF + 1 = 0x100000000 (saturates to 0xFFFFFFFF)
  TEST_CASE_D32( 7, x14, x15, 0xffffffffffffffffL, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x12, 0x00000001; \
    li  x13, 0x00000001; \
    psaddu.dw x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

