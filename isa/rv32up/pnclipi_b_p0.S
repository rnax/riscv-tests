# See LICENSE for license details.

#*****************************************************************************
# pnclipi_b_p0.S
#-----------------------------------------------------------------------------
#
# Test pnclipi.b zero-pair constraint (Phase 2).
# Pattern B only: rs1_p=0 reads as zero, pnclipi(0, imm)=0.
# rd is scalar (not a pair); only the source is a pair.
#
# NOTE: This test FAILS before fixing tcg_gen_mov_i64->tcg_gen_movi_i64 in trans_rvp.c.inc
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Pattern B: rs1_p = 0 — source pair reads as 0, result = 0
  #-------------------------------------------------------------

  # pnclipi.b x14, x0, 4
  # rs1_pair=(x0,x1)=(0,0), pnclipi(0, 4)=0
  # Pre-load x1=0x7fffffff to catch stale high-half bug if present.
  TEST_CASE( 2, x14, 0x00000000, \
    li x1, 0x7fffffff; \
    pnclipi.b x14, x0, 4 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
