# See LICENSE for license details.

#*****************************************************************************
# wmacc_p0.S
#-----------------------------------------------------------------------------
#
# Test wmacc zero-pair constraint (rd_pair=0).
# wmacc is widening multiply-accumulate; rd_pair is also the accumulator.
# When rd_pair=0, the accumulator is treated as 0 and no write occurs.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # wmacc rd_pair, rs1, rs2
  # Widening multiply accumulate (signed):
  #   rd_pair[63:0] = rd_pair[63:0] + (int64_t)rs1 * (int64_t)rs2
  # rd is a register pair and also the accumulator.

  # Pattern A: rd_pair=0 — accumulator is treated as 0, result discarded.
  # wmacc x0, x10, x12 with x10=3, x12=4
  # product = 3*4 = 12; x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 3; \
    li x12, 4; \
    wmacc x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
