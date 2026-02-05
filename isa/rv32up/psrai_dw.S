# See LICENSE for license details.

#*****************************************************************************
# psrai_dw.S
#-----------------------------------------------------------------------------
#
# Test psrai.dw instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic test with immediate 0
  TEST_CASE_D32( 2, x14, x15, 0x0404040404040404, \
    li  x10, 0x04040404; \
    li  x11, 0x04040404; \
    psrai.dw x14, x10, 0; \
  )

  # Test with immediate 1
  TEST_CASE_D32( 3, x14, x15, 0x0808080808080808, \
    li  x10, 0x08080808; \
    li  x11, 0x08080808; \
    psrai.dw x14, x10, 1; \
  )

  # Zero input
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    psrai.dw x14, x10, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
