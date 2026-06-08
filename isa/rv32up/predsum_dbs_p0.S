# See LICENSE for license details.

#*****************************************************************************
# predsum_dbs_p0.S
#-----------------------------------------------------------------------------
#
# Test predsum.dbs zero-pair constraint (rs1_pair=0).
# predsum.dbs has a pair source (rs1_pair) and a scalar destination (rd).
# When rs1_pair=0, all bytes sum to 0, so result = rs2 + 0 = rs2.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # predsum.dbs rd, rs1_pair, rs2_scalar
  # Packed reduction sum (double-word byte signed):
  #   rd = rs2 + sum of 8 sign-extended bytes from rs1 register pair
  # rd is scalar (NOT a pair); rs1 is a register pair.

  # Pattern B: rs1_pair=0 — source pair reads as all zeros.
  # predsum.dbs x14, x0, x12 with x12=42
  # sum of bytes from (0,0) = 0; result = 42 + 0 = 42
  TEST_CASE( 2, x14, 42, \
    li x1, 0xdeadbeef; \
    li x12, 42; \
    predsum.dbs x14, x0, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
