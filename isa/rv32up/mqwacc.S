# See LICENSE for license details.

#*****************************************************************************
# mqwacc.S
#-----------------------------------------------------------------------------
#
# Test mqwacc instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic test
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x12, 0x00000000; \
    mqwacc x14, x10, x12; \
  )

  # Simple values test
  TEST_CASE_D32( 3, x14, x15, 0x0015001500150015, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x03030303; \
    li  x12, 0x07070707; \
    mqwacc x14, x10, x12; \
  )

  # Pattern test
  TEST_CASE_D32( 4, x14, x15, 0x1919191919191919, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x05050505; \
    li  x12, 0x05050505; \
    mqwacc x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
