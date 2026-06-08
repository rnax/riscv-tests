# See LICENSE for license details.

#*****************************************************************************
# subd_p0.S
#-----------------------------------------------------------------------------
#
# Test subd zero-pair constraint (rd_p=0 suppresses write; rs_p=0 reads as 0).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zero-pair constraint tests
  #-------------------------------------------------------------

  # subd rd_pair, rs1_pair, rs2_pair
  # 64-bit subtraction using register pairs.
  # Pair index 0 (x0/x1): writes suppressed; source reads as 0.

  # Pattern A: rd_p=0, destination write suppressed.
  # Pre-load x1=0xdeadbeef; execute subd x0, x10, x12 (rd=x0 -> pair 0).
  # x1 must still be 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 5; \
    li x11, 0; \
    li x12, 3; \
    li x13, 0; \
    subd x0, x10, x12 );

  # Pattern B: rs1_p=0, source reads as 0 pair.
  # subd(0, rs2_pair) = 0 - rs2_pair = -rs2_pair (64-bit negation).
  # rs2_pair = (x12=1, x13=0) = 64-bit value 1.
  # -1 in 64-bit two's complement = 0xffffffff_ffffffff.
  # x14 (low)  = 0xffffffff
  # x15 (high) = 0xffffffff
  TEST_CASE( 3, x14, 0xffffffff, \
    li x1, 0xdeadbeef; \
    li x12, 1; \
    li x13, 0; \
    subd x14, x0, x12 );
  TEST_CASE( 4, x15, 0xffffffff, nop );

  # Pattern C: rs2_p=0, source reads as 0 pair.
  # subd(rs1_pair, 0) = rs1_pair - 0 = rs1_pair.
  # rs1_pair = (x10=5, x11=0).
  # x14 = 5, x15 = 0
  TEST_CASE( 5, x14, 5, \
    li x1, 0xdeadbeef; \
    li x10, 5; \
    li x11, 0; \
    subd x14, x10, x0 );
  TEST_CASE( 6, x15, 0, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
