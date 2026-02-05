# See LICENSE for license details.

#*****************************************************************************
# padd_dh.S
#-----------------------------------------------------------------------------
#
# Test padd.dh instruction (packed add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 + rs2:rs2+1
# 4 elements of 16-bits each, wrapping add
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
    li  x10, 0x00640064; \
    li  x11, 0x00000000; \
    li  x12, 0x00c800c8; \
    li  x13, 0x00000000; \
    padd.dh x14, x10, x12; \
  )

  # Wrapping add: 40000 + 30000 = 70000 (wraps in 16-bit)
  TEST_CASE_D32( 3, x14, x15, 0x11708170, \
    li  x10, 0x9c409c40; \
    li  x11, 0x00000000; \
    li  x12, 0x75307530; \
    li  x13, 0x00000000; \
    padd.dh x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    padd.dh x14, x10, x12; \
  )

  # Large values: 65535 + 1 = 65536 (wraps to 0 in 16-bit)
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0x00010001; \
    li  x13, 0x00000000; \
    padd.dh x14, x10, x12; \
  )

  # Mixed values: 1000 + 500 = 1500 for each halfword
  TEST_CASE_D32( 6, x14, x15, 0x05dc05dc05dc05dc, \
    li  x10, 0x03e803e8; \
    li  x11, 0x00000000; \
    li  x12, 0x01f401f4; \
    li  x13, 0x00000000; \
    padd.dh x14, x10, x12; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x012c012c012c012c, \
    li  x10, 0x00640064; \
    li  x10, 0x00000000; \
    li  x11, 0x00c800c8; \
    li  x12, 0x00000000; \
    padd.dh x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

