# See LICENSE for license details.

#*****************************************************************************
# pusati_dw.S
#-----------------------------------------------------------------------------
#
# Test pusati.dw instruction (packed unsigned saturation immediate double-word).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1, shamtw + 1) [unsigned]
# 2 elements of 32-bits each, with saturation to specified bit width
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturation to 1-bit: 0x00000001 -> 0x00000001 (saturates to 1)
  TEST_CASE_D32( 2, x14, x15, 0x0000000100000001, \
    li  x11, 0x00000001; \
    li  x12, 0x00000001; \
    pusati.dw x14, x11, 0; \
  )

  # Saturation to 8-bit: 0x000000FF -> 0x000000FF (fits)
  TEST_CASE_D32( 3, x14, x15, 0x000000ff000000ff, \
    li  x11, 0x000000ff; \
    li  x12, 0x000000ff; \
    pusati.dw x14, x11, 7; \
  )

  # Saturation to 8-bit: 0x00000100 -> 0x000000FF (saturates)
  TEST_CASE_D32( 4, x14, x15, 0x000000ff000000ff, \
    li  x11, 0x00000100; \
    li  x12, 0x00000100; \
    pusati.dw x14, x11, 7; \
  )

  # Saturation to 16-bit: 0x0000FFFF -> 0x0000FFFF (fits)
  TEST_CASE_D32( 5, x14, x15, 0x0000ffff0000ffff, \
    li  x11, 0x0000ffff; \
    li  x12, 0x0000ffff; \
    pusati.dw x14, x11, 15; \
  )

  # Saturation to 16-bit: 0x00010000 -> 0x0000FFFF (saturates)
  TEST_CASE_D32( 6, x14, x15, 0x0000ffff0000ffff, \
    li  x11, 0x00010000; \
    li  x12, 0x00010000; \
    pusati.dw x14, x11, 15; \
  )

  # Zero input
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    pusati.dw x14, x11, 7; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

