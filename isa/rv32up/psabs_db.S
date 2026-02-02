# See LICENSE for license details.

#*****************************************************************************
# psabs_db.S
#-----------------------------------------------------------------------------
#
# Test psabs.db instruction (packed signed absolute value double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = |rs1:rs1+1|
# 8 elements of 8-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive values: |4| = 4
  TEST_CASE_D32( 2, x14, x15, 0x0404040404040404, \
    li  x11, 0x04040404; \
    li  x12, 0x00000000; \
    psabs.db x14, x11; \
  )

  # Negative values: |-4| = 4
  TEST_CASE_D32( 3, x14, x15, 0x0404040404040404, \
    li  x11, 0xfcfcfcfc; \
    li  x12, 0xffffffff; \
    psabs.db x14, x11; \
  )

  # Zero: |0| = 0
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    psabs.db x14, x11; \
  )

  # Mixed positive and negative: |100| = 100, |-50| = 50
  TEST_CASE_D32( 5, x14, x15, 0x6464646464646464, \
    li  x11, 0x64646464; \
    li  x12, 0x00000000; \
    psabs.db x14, x11; \
  )

  # Max positive: |127| = 127
  TEST_CASE_D32( 6, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    li  x11, 0x7f7f7f7f; \
    li  x12, 0x00000000; \
    psabs.db x14, x11; \
  )

  # Min negative: |-128| = 128 (overflow case)
  TEST_CASE_D32( 7, x14, x15, 0x8080808080808080, \
    li  x11, 0x80808080; \
    li  x12, 0xffffffff; \
    psabs.db x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

