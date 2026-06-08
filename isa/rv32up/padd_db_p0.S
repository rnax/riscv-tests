# See LICENSE for license details.

#*****************************************************************************
# padd_db_p0.S
#-----------------------------------------------------------------------------
#
# Test padd.db zero-pair constraint (rd_p=0 suppresses write; rs_p=0 reads as 0).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zero-pair constraint tests
  #-------------------------------------------------------------

  # padd.db rd_pair, rs1_pair, rs2_pair
  # Packed byte addition on 64-bit register pairs.
  # Pair index 0 (x0/x1): writes suppressed; source reads as 0.

  # Pattern A: rd_p=0, destination write suppressed.
  # Pre-load x1=0xdeadbeef; execute padd.db x0, x10, x12 (rd=x0 -> pair 0).
  # x1 must still be 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x01020304; \
    li x11, 0x05060708; \
    li x12, 0x09080706; \
    li x13, 0x0d0c0b0a; \
    padd.db x0, x10, x12 );

  # Pattern B: rs1_p=0, source reads as 0 pair.
  # padd.db(0, rs2_pair) = rs2_pair (byte add with 0 = identity).
  # Low word: 0x00000000 + 0x09080706 = 0x09080706
  # High word: 0x00000000 + 0x0d0c0b0a = 0x0d0c0b0a
  TEST_CASE( 3, x14, 0x09080706, \
    li x1, 0xdeadbeef; \
    li x12, 0x09080706; \
    li x13, 0x0d0c0b0a; \
    padd.db x14, x0, x12 );
  TEST_CASE( 4, x15, 0x0d0c0b0a, nop );

  # Pattern C: rs2_p=0, source reads as 0 pair.
  # padd.db(rs1_pair, 0) = rs1_pair (byte add with 0 = identity).
  # Low word: 0x01020304 + 0x00000000 = 0x01020304
  # High word: 0x05060708 + 0x00000000 = 0x05060708
  TEST_CASE( 5, x14, 0x01020304, \
    li x1, 0xdeadbeef; \
    li x10, 0x01020304; \
    li x11, 0x05060708; \
    padd.db x14, x10, x0 );
  TEST_CASE( 6, x15, 0x05060708, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
