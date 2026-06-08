# See LICENSE for license details.

#*****************************************************************************
# wzip8p_p0.S
#-----------------------------------------------------------------------------
#
# Test wzip8p zero-pair constraint (rd_pair=0).
# wzip8p has scalar inputs and a pair output; when rd_pair=0 it returns early.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # wzip8p rd_pair, rs1, rs2
  # Widening zip 8-bit: rd[i] = rs2[i] << 8 | rs1[i]
  # rs1 and rs2 are scalar registers; rd is a register pair.
  # When rd_pair=0, an early-return guard skips the write entirely.

  # Pattern A: rd_pair=0 — early return, x1 must be unchanged.
  # wzip8p x0, x10, x12 with x10=0x04030201, x12=0x14131211
  # x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x04030201; \
    li x12, 0x14131211; \
    wzip8p x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
