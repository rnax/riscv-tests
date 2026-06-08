# See LICENSE for license details.

#*****************************************************************************
# nsrli_p0.S
#-----------------------------------------------------------------------------
#
# Test nsrli zero-pair constraint (Phase 2).
# Pattern B only: rs1_p=0 reads as zero, nsrli(0, imm)=0.
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

  # nsrli x14, x0, 1
  # rs1_pair=(x0,x1)=(0,0), nsrli(0, 1)=0
  # Pre-load x1=0x7fffffff to catch stale high-half bug if present.
  TEST_CASE( 2, x14, 0x00000000, \
    li x1, 0x7fffffff; \
    nsrli x14, x0, 1 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
