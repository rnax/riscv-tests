# See LICENSE for license details.

#*****************************************************************************
# padd_dw_p0.S
#-----------------------------------------------------------------------------
#
# Test padd.dw zero-pair constraint (rd_p=0 suppresses write; rs_p=0 reads as 0).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zero-pair constraint tests
  #-------------------------------------------------------------

  # padd.dw rd_pair, rs1_pair, rs2_pair
  # Packed word addition on 64-bit register pairs (two 32-bit elements).
  # Pair index 0 (x0/x1): writes suppressed; source reads as 0.

  # Pattern A: rd_p=0, destination write suppressed.
  # Pre-load x1=0xdeadbeef; execute padd.dw x0, x10, x12 (rd=x0 -> pair 0).
  # x1 must still be 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x11111111; \
    li x11, 0x22222222; \
    li x12, 0x33333333; \
    li x13, 0x44444444; \
    padd.dw x0, x10, x12 );

  # Pattern B: rs1_p=0, source reads as 0 pair.
  # padd.dw(0, rs2_pair) = 0 + rs2_pair = rs2_pair (word add with 0 = identity).
  # x14 (low)  = 0x33333333
  # x15 (high) = 0x44444444
  TEST_CASE( 3, x14, 0x33333333, \
    li x1, 0xdeadbeef; \
    li x12, 0x33333333; \
    li x13, 0x44444444; \
    padd.dw x14, x0, x12 );
  TEST_CASE( 4, x15, 0x44444444, nop );

  # Pattern C: rs2_p=0, source reads as 0 pair.
  # padd.dw(rs1_pair, 0) = rs1_pair + 0 = rs1_pair (word add with 0 = identity).
  # x14 (low)  = 0x11111111
  # x15 (high) = 0x22222222
  TEST_CASE( 5, x14, 0x11111111, \
    li x1, 0xdeadbeef; \
    li x10, 0x11111111; \
    li x11, 0x22222222; \
    padd.dw x14, x10, x0 );
  TEST_CASE( 6, x15, 0x22222222, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
