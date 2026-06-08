# See LICENSE for license details.

#*****************************************************************************
# pwadd_b_p0.S
#-----------------------------------------------------------------------------
#
# Test pwadd.b zero-pair constraint (rd_p=0 suppresses write).
# rs1 and rs2 are scalar registers (not pairs), so only Pattern A applies.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zero-pair constraint tests
  #-------------------------------------------------------------

  # pwadd.b rd_pair, rs1, rs2
  # Packed widening byte add: rd is a register pair, rs1 and rs2 are scalars.
  # Pair index 0 (x0/x1): writes to rd_pair suppressed when rd=x0.

  # Pattern A: rd_p=0, destination write suppressed.
  # Pre-load x1=0xdeadbeef; execute pwadd.b x0, x10, x12 (rd=x0 -> pair 0).
  # x1 must still be 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x01020304; \
    li x12, 0x02020202; \
    pwadd.b x0, x10, x12 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
