# See LICENSE for license details.

#*****************************************************************************
# psabs_dh.S
#-----------------------------------------------------------------------------
#
# Test psabs.dh instruction (packed signed absolute value double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = |rs1:rs1+1|
# 4 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive values: |1000| = 1000
  TEST_CASE_D32( 2, x14, x15, 0x03e803e803e803e8, \
    li  x11, 0x03e803e8; \
    li  x12, 0x00000000; \
    psabs.dh x14, x11; \
  )

  # Negative values: |-1000| = 1000
  TEST_CASE_D32( 3, x14, x15, 0x03e803e803e803e8, \
    li  x11, 0xfc18fc18; \
    li  x12, 0xffffffff; \
    psabs.dh x14, x11; \
  )

  # Zero: |0| = 0
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    psabs.dh x14, x11; \
  )

  # Max positive: |32767| = 32767
  TEST_CASE_D32( 5, x14, x15, 0x7fff7fff7fff7fff, \
    li  x11, 0x7fff7fff; \
    li  x12, 0x00000000; \
    psabs.dh x14, x11; \
  )

  # Min negative: |-32768| = 32768 (overflow case)
  TEST_CASE_D32( 6, x14, x15, 0x8000800080008000, \
    li  x11, 0x80008000; \
    li  x12, 0xffffffff; \
    psabs.dh x14, x11; \
  )

  # Mixed: |100| = 100, |-200| = 200
  TEST_CASE_D32( 7, x14, x15, 0x00c800640064006c, \
    li  x11, 0x00640064; \
    li  x12, 0x00000000; \
    psabs.dh x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

