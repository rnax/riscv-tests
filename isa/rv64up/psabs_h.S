# See LICENSE for license details.

#*****************************************************************************
# psabs_h.S
#-----------------------------------------------------------------------------
#
# Test psabs.h instruction (packed signed absolute value halfword).
# Operates on 32-bit register: rd = |rs1|
# 2 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive values: |1000| = 1000
  TEST_CASE( 2, x14, 0x03e803e8, \
    li  x11, 0x03e803e8; \
    psabs.h x14, x11; \
  )

  # Negative values: |-1000| = 1000
  TEST_CASE( 3, x14, 0x03e803e8, \
    li  x11, 0xfc18fc18; \
    psabs.h x14, x11; \
  )

  # Zero: |0| = 0
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x00000000; \
    psabs.h x14, x11; \
  )

  # Max positive: |32767| = 32767
  TEST_CASE( 5, x14, 0x7fff7fff, \
    li  x11, 0x7fff7fff; \
    psabs.h x14, x11; \
  )

  # Min negative: |-32768| = 32768 (overflow case)
  TEST_CASE( 6, x14, 0x80008000, \
    li  x11, 0x80008000; \
    psabs.h x14, x11; \
  )

  # Mixed: |100| = 100, |-200| = 200
  TEST_CASE( 7, x14, 0x00c800c8, \
    li  x11, 0x00c8ff38; \
    psabs.h x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

