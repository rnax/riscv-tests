# See LICENSE for license details.

#*****************************************************************************
# plui_dh.S
#-----------------------------------------------------------------------------
#
# Test plui.dh instruction (packed load upper immediate double-halfword).
# Loads a 16-bit immediate into the upper 16 bits of each 32-bit word.
# rd:rd+1 = {imm << 16, imm << 16}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Load immediate 0 << 16
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    plui.dh x14, 0; \
  )

  # Load immediate 0x100 << 16
  TEST_CASE_D32( 3, x14, x15, 0x0100000001000000, \
    plui.dh x14, 0x100; \
  )

  # Load immediate -1 << 16 (0xffff pattern)
  TEST_CASE_D32( 4, x14, x15, 0xffff0000ffff0000, \
    plui.dh x14, -1; \
  )

  # Load immediate 0x1ff << 16 (max positive in range)
  TEST_CASE_D32( 5, x14, x15, 0x01ff000001ff0000, \
    plui.dh x14, 0x1ff; \
  )

  # Load immediate -512 << 16 (0xfe00 pattern)
  TEST_CASE_D32( 6, x14, x15, 0xfe000000fe000000, \
    plui.dh x14, -512; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

