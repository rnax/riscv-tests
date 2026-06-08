# See LICENSE for license details.

#*****************************************************************************
# wmul_p0.S
#-----------------------------------------------------------------------------
#
# Test wmul zero-pair constraint (rd_pair=0).
# wmul is widening 32-to-64 signed multiply with a pair output.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # wmul rd_pair, rs1, rs2
  # Widening multiply (signed): rd_pair = (int64_t)rs1 * (int64_t)rs2
  # rs1 and rs2 are scalar registers; rd is a register pair.

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # wmul x0, x10, x12 with x10=3, x12=4
  # result = 12; x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 3; \
    li x12, 4; \
    wmul x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
