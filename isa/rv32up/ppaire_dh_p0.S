# See LICENSE for license details.

#*****************************************************************************
# ppaire_dh_p0.S
#-----------------------------------------------------------------------------
#
# Test ppaire.dh zero-pair constraint (rd_pair=0, rs1_pair=0, rs2_pair=0).
# ppaire.dh selects even halfwords from each register pair and packs them:
#   d_w = (s2_w[15:0] << 16) | s1_w[15:0]   (even = lower halfword)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  # ppaire.dh rd_pair, rs1_pair, rs2_pair
  # Pack even (lower) halfwords from rs1 and rs2 pairs into rd pair.
  # Per word: d_w = (s2_w[15:0] << 16) | s1_w[15:0]

  # Pattern A: rd_pair=0 — result is discarded, x1 must be unchanged.
  # ppaire.dh x0, x10, x12
  # x10=0x00010000, x11=0x00030002, x12=0x00050004, x13=0x00070006
  # x0/x1 must not be written; x1 remains 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x00010000; \
    li x11, 0x00030002; \
    li x12, 0x00050004; \
    li x13, 0x00070006; \
    ppaire.dh x0, x10, x12 );

  # Pattern B: rs1_pair=0 — rs1 pair reads as all zeros (even halfwords = 0).
  # ppaire.dh x14, x0, x12 with x12=0x00050004, x13=0x00070006
  # Per word: d_lo = (0x0004 << 16) | 0x0000 = 0x00040000
  #           d_hi = (0x0006 << 16) | 0x0000 = 0x00060000
  TEST_CASE( 3, x14, 0x00040000, \
    li x12, 0x00050004; \
    li x13, 0x00070006; \
    ppaire.dh x14, x0, x12 );
  TEST_CASE( 4, x15, 0x00060000, nop );

  # Pattern C: rs2_pair=0 — rs2 pair reads as all zeros (even halfwords = 0).
  # ppaire.dh x14, x10, x0 with x10=0x00010000, x11=0x00030002
  # Per word: d_lo = (0x0000 << 16) | 0x0000 = 0x00000000
  #           d_hi = (0x0000 << 16) | 0x0002 = 0x00000002
  TEST_CASE( 5, x14, 0x00000000, \
    li x10, 0x00010000; \
    li x11, 0x00030002; \
    ppaire.dh x14, x10, x0 );
  TEST_CASE( 6, x15, 0x00000002, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
