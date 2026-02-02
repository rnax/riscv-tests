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

  # Load immediate 0x0000 << 16
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000000, \
    plui.dh x14, 0x0000; \
  )

  # Load immediate 0x1234 << 16
  TEST_CASE_D32( 3, x14, x15, 0x1234000012340000, \
    plui.dh x14, 0x1234; \
  )

  # Load immediate 0xffff << 16
  TEST_CASE_D32( 4, x14, x15, 0xffffffff00000000, \
    plui.dh x14, 0xffff; \
  )

  # Load immediate 0x7fff << 16 (max positive)
  TEST_CASE_D32( 5, x14, x15, 0x7fff00007fff0000, \
    plui.dh x14, 0x7fff; \
  )

  # Load immediate 0x8000 << 16 (min negative)
  TEST_CASE_D32( 6, x14, x15, 0x8000000080000000, \
    plui.dh x14, 0x8000; \
  )

  # Load immediate 0xaaaa << 16
  TEST_CASE_D32( 7, x14, x15, 0xaaaa0000aaaa0000, \
    plui.dh x14, 0xaaaa; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

