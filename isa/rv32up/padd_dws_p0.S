# See LICENSE for license details.

#*****************************************************************************
# padd_dws_p0.S
#-----------------------------------------------------------------------------
#
# Test padd.dws zero-pair constraint (rd_pair=0 and rs1_pair=0).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # padd.dws rd_pair, rs1_pair, rs2_scalar
  # Packed word add with scalar broadcast on 64-bit register pairs.
  # When rd_pair=0 or rs1_pair=0, the zero-pair constraint applies.

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # padd.dws x0, x10, x12 with x10=5, x11=10, x12=3
  # x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 5; \
    li x11, 10; \
    li x12, 3; \
    padd.dws x0, x10, x12 );

  # Pattern B: rs1_pair=0 — both halves of source pair read as 0.
  # padd.dws x14, x0, x12 with x12=7
  # result_lo = 0 + 7 = 7, result_hi = 0 + 7 = 7
  TEST_CASE( 3, x14, 7, \
    li x12, 7; \
    padd.dws x14, x0, x12 );
  TEST_CASE( 4, x15, 7, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
