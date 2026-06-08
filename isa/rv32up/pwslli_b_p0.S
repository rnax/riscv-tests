# See LICENSE for license details.

#*****************************************************************************
# pwslli_b_p0.S
#-----------------------------------------------------------------------------
#
# Test pwslli.b zero-pair constraint (rd_pair=0).
# pwslli.b is packed widening shift-left-logical immediate (byte to halfword).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # pwslli.b rd_pair, rs1, imm
  # Packed widening shift left logical immediate: each byte in rs1 is
  # zero-extended to a halfword and shifted left by imm.
  # rs1 is a scalar register; rd is a register pair.

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # pwslli.b x0, x10, 1 with x10=0x01020304
  # bytes: 1<<1=2, 2<<1=4, 3<<1=6, 4<<1=8
  # x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x01020304; \
    pwslli.b x0, x10, 1 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
