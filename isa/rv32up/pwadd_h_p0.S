# See LICENSE for license details.

#*****************************************************************************
# pwadd_h_p0.S
#-----------------------------------------------------------------------------
#
# Test pwadd.h zero-pair constraint (rd_pair=0).
# pwadd.h has scalar inputs and a pair output.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # pwadd.h rd_pair, rs1, rs2
  # Packed widening halfword add: rd_pair[i] = sign_ext(rs1[i]) + sign_ext(rs2[i])
  # rs1 and rs2 are scalar registers; rd is a register pair.

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # pwadd.h x0, x10, x12 with x10=0x00010001, x12=0x00020002
  # Each halfword: 1+2=3; x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x00010001; \
    li x12, 0x00020002; \
    pwadd.h x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
