# See LICENSE for license details.

#*****************************************************************************
# psll_dws_p0.S
#-----------------------------------------------------------------------------
#
# Test psll.dws zero-pair constraint (rd_pair=0 and rs1_pair=0).
# psll.dws uses the explicit-branch path for shamt>=32.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # psll.dws rd_pair, rs1_pair, rs2_scalar
  # Packed word left-shift with scalar broadcast on 64-bit register pairs.
  # When rd_pair=0 or rs1_pair=0, the zero-pair constraint applies.

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # psll.dws x0, x10, x12 with x10=0x11111111, x11=0x22222222, x12=1
  # x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x11111111; \
    li x11, 0x22222222; \
    li x12, 1; \
    psll.dws x0, x10, x12 );

  # Pattern B: rs1_pair=0 — both halves of source pair read as 0.
  # psll.dws x14, x0, x12 with x12=1
  # result_lo = 0 << 1 = 0, result_hi = 0 << 1 = 0
  TEST_CASE( 3, x14, 0, \
    li x12, 1; \
    psll.dws x14, x0, x12 );
  TEST_CASE( 4, x15, 0, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
