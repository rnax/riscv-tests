# See LICENSE for license details.

#*****************************************************************************
# psshar_dhs.S
#-----------------------------------------------------------------------------
#
# Test psshar.dhs instruction (packed saturating shift left arithmetic with rounding double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 << shamt) with rounding
# 4 elements of 16-bits each, with saturation and rounding
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic left shift with rounding: 0x0001 << 1 = 0x0002
  TEST_CASE_D32( 2, x14, x15, 0x0002000200020002, \
    li  x11, 0x00010001; \
    li  x12, 0x00000000; \
    psshar.dhs x14, x11, 1; \
  )

  # Left shift with rounding: 0x0005 << 2 = 0x0014
  TEST_CASE_D32( 3, x14, x15, 0x0014001400140014, \
    li  x11, 0x00050005; \
    li  x12, 0x00000000; \
    psshar.dhs x14, x11, 2; \
  )

  # Saturation with rounding: 0x4000 << 1 saturates to 0x7FFF
  TEST_CASE_D32( 4, x14, x15, 0x7fff7fff7fff7fff, \
    li  x11, 0x40004000; \
    li  x12, 0x00000000; \
    psshar.dhs x14, x11, 1; \
  )

  # Saturation with rounding: 0xC000 << 1 saturates to 0x8000
  TEST_CASE_D32( 5, x14, x15, 0x8000800080008000, \
    li  x11, 0xc000c000; \
    li  x12, 0x00000000; \
    psshar.dhs x14, x11, 1; \
  )

  # Zero input
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    psshar.dhs x14, x11, 1; \
  )

  # Zero shift amount
  TEST_CASE_D32( 7, x14, x15, 0x00050005, \
    li  x11, 0x00050005; \
    li  x12, 0x00000000; \
    psshar.dhs x14, x11, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

