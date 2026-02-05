# See LICENSE for license details.

#*****************************************************************************
# psabs_b.S
#-----------------------------------------------------------------------------
#
# Test psabs.b instruction (packed signed absolute value byte).
# Operates on 32-bit register: rd = |rs1|
# 4 elements of 8-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive values: |4| = 4
  TEST_CASE( 2, x14, 0x04040404, \
    li  x11, 0x04040404; \
    psabs.b x14, x11; \
  )

  # Negative values: |-4| = 4
  TEST_CASE( 3, x14, 0x04040404, \
    li  x11, 0xfcfcfcfc; \
    psabs.b x14, x11; \
  )

  # Zero: |0| = 0
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x00000000; \
    psabs.b x14, x11; \
  )

  # Max positive: |127| = 127
  TEST_CASE( 5, x14, 0x7f7f7f7f, \
    li  x11, 0x7f7f7f7f; \
    psabs.b x14, x11; \
  )

  # Min negative: |-128| = 128 (overflow case)
  TEST_CASE( 6, x14, 0x80808080, \
    li  x11, 0x80808080; \
    psabs.b x14, x11; \
  )

  # Mixed: |100| = 100, |-50| = 50
  TEST_CASE( 7, x14, 0x64646464, \
    li  x11, 0x64646464; \
    psabs.b x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

