# See LICENSE for license details.

#*****************************************************************************
# psabs_db.S
#-----------------------------------------------------------------------------
#
# Test psabs.db instruction (packed signed absolute value).
# rd:rd+1 = |rs1:rs1+1| element-wise
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Positive values: |4| = 4
  TEST_CASE_D32( 2, x14, x15, 0x0404040404040404, \
    li  x10, 0x04040404; \
    li  x11, 0x04040404; \
    psabs.db x14, x10; \
  )

  # Zero
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    psabs.db x14, x10; \
  )

  # Mixed values
  TEST_CASE_D32( 4, x14, x15, 0x6464646464646464, \
    li  x10, 0x64646464; \
    li  x11, 0x64646464; \
    psabs.db x14, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
