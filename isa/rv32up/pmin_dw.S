# See LICENSE for license details.

#*****************************************************************************
# pmin_dw.S
#-----------------------------------------------------------------------------
#
# Test pmin.dw instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic test
  TEST_CASE_D32( 2, x14, x15, 0x0505050505050505, \
    li  x10, 0x03030303; \
    li  x11, 0x03030303; \
    li  x12, 0x05050505; \
    li  x13, 0x05050505; \
    pmin.dw x14, x10, x12; \
  )

  # All zeros
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pmin.dw x14, x10, x12; \
  )

  # Pattern test  
  TEST_CASE_D32( 4, x14, x15, 0x5555555555555555, \
    li  x10, 0x55555555; \
    li  x11, 0x55555555; \
    li  x12, 0x55555555; \
    li  x13, 0x55555555; \
    pmin.dw x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
