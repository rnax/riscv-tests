# See LICENSE for license details.

#*****************************************************************************
# psadd_dh.S
#-----------------------------------------------------------------------------
#
# Test psadd.dh instruction (packed saturating add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 + rs2:rs2+1)
# 4 elements of 16-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100 + 200 = 300 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x012c012c012c012c, \
    li  x11, 0x00640064; \
    li  x12, 0x00000000; \
    li  x13, 0x00c800c8; \
    li  x16, 0x00000000; \
    psadd.dh x14, x11, x13; \
  )

  # Saturation at max positive: 20000 + 20000 = 40000 (saturates to 32767)
  TEST_CASE_D32( 3, x14, x15, 0x7fff7fff7fff7fff, \
    li  x11, 0x4e204e20; \
    li  x12, 0x00000000; \
    li  x13, 0x4e204e20; \
    li  x16, 0x00000000; \
    psadd.dh x14, x11, x13; \
  )

  # Saturation at min negative: -20000 + -20000 = -40000 (saturates to -32768)
  TEST_CASE_D32( 4, x14, x15, 0x8000800080008000, \
    li  x11, 0xb1e0b1e0; \
    li  x12, 0x00000000; \
    li  x13, 0xb1e0b1e0; \
    li  x16, 0x00000000; \
    psadd.dh x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    psadd.dh x14, x11, x13; \
  )

  # Mixed values: 1000 + 500 = 1500
  TEST_CASE_D32( 6, x14, x15, 0x05dc05dc05dc05dc, \
    li  x11, 0x03e803e8; \
    li  x12, 0x00000000; \
    li  x13, 0x01f401f4; \
    li  x16, 0x00000000; \
    psadd.dh x14, x11, x13; \
  )

  # Negative operands: -1000 + -500 = -1500
  TEST_CASE_D32( 7, x14, x15, 0xfa24fa24fa24fa24, \
    li  x11, 0xfc18fc18; \
    li  x12, 0x00000000; \
    li  x13, 0xfe0cfe0c; \
    li  x16, 0x00000000; \
    psadd.dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

