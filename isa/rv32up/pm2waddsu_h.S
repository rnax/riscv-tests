# See LICENSE for license details.

#*****************************************************************************
# pm2waddsu_h.S
#-----------------------------------------------------------------------------
#
# Test pm2waddsu.h instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic test: simple multiply
  TEST_CASE_D32( 2, x14, x15, 0x0000002100000015, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x00030003; \
    li  x12, 0x00070007; \
    pm2waddsu.h x14, x10, x12; \
  )

  # All zeros
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x12, 0x00000000; \
    pm2waddsu.h x14, x10, x12; \
  )

  # Pattern test
  TEST_CASE_D32( 4, x14, x15, 0x0019001900190019, \
    li  x14, 0x00000000; \
    li  x15, 0x00000000; \
    li  x10, 0x00050005; \
    li  x12, 0x00050005; \
    pm2waddsu.h x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
