# See LICENSE for license details.

#*****************************************************************************
# psext_dw_h.S
#-----------------------------------------------------------------------------
#
# Test psext.dw.h instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic test
  TEST_CASE_D32( 2, x14, x15, 0x0404040404040404, \
    li  x10, 0x04040404; \
    li  x11, 0x04040404; \
    psext.dw.h x14, x10; \
  )

  # Pattern test
  TEST_CASE_D32( 3, x14, x15, 0x0808080808080808, \
    li  x10, 0x08080808; \
    li  x11, 0x08080808; \
    psext.dw.h x14, x10; \
  )

  # Zero input
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    psext.dw.h x14, x10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
