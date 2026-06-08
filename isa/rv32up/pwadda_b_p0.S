# See LICENSE for license details.

#*****************************************************************************
# pwadda_b_p0.S
#-----------------------------------------------------------------------------
#
# Test pwadda.b zero-pair constraint (rd_pair=0).
# pwadda.b is packed widening byte add-accumulate; rd_pair is also the accumulator.
# When rd_pair=0, the accumulator read is skipped and no write occurs.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # pwadda.b rd_pair, rs1, rs2
  # Packed widening byte add-accumulate:
  #   rd_pair[i] = rd_pair[i] + sign_ext(rs1[i]) + sign_ext(rs2[i])
  # rd is a register pair and also the accumulator.

  # Pattern A: rd_pair=0 — accumulator read is skipped, result discarded.
  # pwadda.b x0, x10, x12 with x10=0x01020304, x12=0x02020202
  # Pre-load x14=0xAABBCCDD, x15=0x11223344 as potential accumulator values,
  # but with rd=x0 these should be ignored and x0/x1 not written.
  # x1 must remain 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x14, 0xAABBCCDD; \
    li x15, 0x11223344; \
    li x10, 0x01020304; \
    li x12, 0x02020202; \
    pwadda.b x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
