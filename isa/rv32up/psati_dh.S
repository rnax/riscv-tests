# See LICENSE for license details.

#*****************************************************************************
# psati_dh.S
#-----------------------------------------------------------------------------
#
# Test psati.dh instruction (packed saturation immediate double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1, shamtw + 1) [signed]
# 4 elements of 16-bits each, with saturation to specified bit width
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturation to 1-bit: 0x0001 -> 0x0000 (fits in 1 bit)
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    li  x10, 0x00010001; \
    li  x11, 0x00000000; \
    psati.dh x14, x11, 0; \
  )

  # Saturation to 8-bit: 0x007F -> 0x007F (fits)
  TEST_CASE_D32( 3, x14, x15, 0x007f007f007f007f, \
    li  x10, 0x007f007f; \
    li  x11, 0x00000000; \
    psati.dh x14, x11, 6; \
  )

  # Saturation to 8-bit: 0x0080 -> 0x007F (saturates)
  TEST_CASE_D32( 4, x14, x15, 0x007f007f007f007f, \
    li  x10, 0x00800080; \
    li  x11, 0x00000000; \
    psati.dh x14, x11, 6; \
  )

  # Saturation to 16-bit: 0x7FFF -> 0x7FFF (fits)
  TEST_CASE_D32( 5, x14, x15, 0x7fff7fff7fff7fff, \
    li  x10, 0x7fff7fff; \
    li  x11, 0x00000000; \
    psati.dh x14, x11, 14; \
  )

  # Saturation to 16-bit: 0x8000 -> 0x7FFF (saturates)
  TEST_CASE_D32( 6, x14, x15, 0x7fff7fff7fff7fff, \
    li  x10, 0x80008000; \
    li  x11, 0x00000000; \
    psati.dh x14, x11, 14; \
  )

  # Negative: -1 fits in any bit width
  TEST_CASE_D32( 7, x14, x15, 0xffffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    psati.dh x14, x11, 6; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

