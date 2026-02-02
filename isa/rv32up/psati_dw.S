# See LICENSE for license details.

#*****************************************************************************
# psati_dw.S
#-----------------------------------------------------------------------------
#
# Test psati.dw instruction (packed saturation immediate double-word).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1, shamtw + 1) [signed]
# 2 elements of 32-bits each, with saturation to specified bit width
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturation to 1-bit: 0x00000001 -> 0x00000000 (fits in 1 bit)
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000001; \
    li  x12, 0x00000001; \
    psati.dw x14, x11, 0; \
  )

  # Saturation to 8-bit: 0x0000007F -> 0x0000007F (fits)
  TEST_CASE_D32( 3, x14, x15, 0x0000007f0000007f, \
    li  x11, 0x0000007f; \
    li  x12, 0x0000007f; \
    psati.dw x14, x11, 6; \
  )

  # Saturation to 8-bit: 0x00000080 -> 0x0000007F (saturates)
  TEST_CASE_D32( 4, x14, x15, 0x0000007f0000007f, \
    li  x11, 0x00000080; \
    li  x12, 0x00000080; \
    psati.dw x14, x11, 6; \
  )

  # Saturation to 16-bit: 0x00007FFF -> 0x00007FFF (fits)
  TEST_CASE_D32( 5, x14, x15, 0x00007fff00007fff, \
    li  x11, 0x00007fff; \
    li  x12, 0x00007fff; \
    psati.dw x14, x11, 14; \
  )

  # Saturation to 16-bit: 0x00008000 -> 0x00007FFF (saturates)
  TEST_CASE_D32( 6, x14, x15, 0x00007fff00007fff, \
    li  x11, 0x00008000; \
    li  x12, 0x00008000; \
    psati.dw x14, x11, 14; \
  )

  # Negative: -1 fits in any bit width
  TEST_CASE_D32( 7, x14, x15, 0xffffffffffffffffL, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    psati.dw x14, x11, 6; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

