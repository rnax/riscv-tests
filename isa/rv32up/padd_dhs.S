# See LICENSE for license details.

#*****************************************************************************
# padd_dhs.S
#-----------------------------------------------------------------------------
#
# Test padd.dhs instruction (packed add double-halfword saturating).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 + rs2:rs2+1 (saturated)
# 4 elements of 16-bits each, signed saturating add
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
    padd.dhs x14, x11, x13; \
  )

  # Positive saturation: 20000 + 20000 = 40000 (saturates to 32767 in signed 16-bit)
  TEST_CASE_D32( 3, x14, x15, 0x7fff7fff7fff7fff, \
    li  x11, 0x4e204e20; \
    li  x12, 0x00000000; \
    li  x13, 0x4e204e20; \
    li  x16, 0x00000000; \
    padd.dhs x14, x11, x13; \
  )

  # Negative saturation: -20000 + -20000 = -40000 (saturates to -32768 in signed 16-bit)
  TEST_CASE_D32( 4, x14, x15, 0x8000800080008000, \
    li  x11, 0xb1e0b1e0; \
    li  x12, 0xffffffff; \
    li  x13, 0xb1e0b1e0; \
    li  x16, 0xffffffff; \
    padd.dhs x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    padd.dhs x14, x11, x13; \
  )

  # No saturation: 1000 + 500 = 1500 for each halfword
  TEST_CASE_D32( 6, x14, x15, 0x05dc05dc05dc05dc, \
    li  x11, 0x03e803e8; \
    li  x12, 0x00000000; \
    li  x13, 0x01f401f4; \
    li  x16, 0x00000000; \
    padd.dhs x14, x11, x13; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x012c012c012c012c, \
    li  x10, 0x00640064; \
    li  x11, 0x00000000; \
    li  x12, 0x00c800c8; \
    li  x13, 0x00000000; \
    padd.dhs x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

