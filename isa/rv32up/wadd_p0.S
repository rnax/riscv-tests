# See LICENSE for license details.

#*****************************************************************************
# wadd_p0.S
#-----------------------------------------------------------------------------
#
# Test wadd zero-pair constraint (rd_pair=0).
# wadd has scalar inputs and a pair output (widening 32-to-64 add).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # wadd rd_pair, rs1, rs2
  # Widening add: rd_pair = sign_ext(rs1) + sign_ext(rs2)
  # rs1 and rs2 are scalar registers; rd is a register pair.

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # wadd x0, x10, x12 with x10=5, x12=3
  # result = 8; x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 5; \
    li x12, 3; \
    wadd x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
