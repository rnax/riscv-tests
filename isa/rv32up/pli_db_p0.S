# See LICENSE for license details.

#*****************************************************************************
# pli_db_p0.S
#-----------------------------------------------------------------------------
#
# Test pli.db zero-pair constraint.
# Pattern A only: rd_p=0 suppresses the write (pli.db has no source registers).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Pattern A: rd_p = 0 — write suppressed, x1 unchanged
  #-------------------------------------------------------------

  # pli.db x0, 1 — rd_p=0, write suppressed; x1 must be untouched.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    pli.db x0, 1 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
