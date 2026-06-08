# See LICENSE for license details.

#*****************************************************************************
# psslai_dw_p0.S
#-----------------------------------------------------------------------------
#
# Test psslai.dw zero-pair constraint.
# Pattern A: rd_p=0 suppresses the write.
# Pattern B: rs1_p=0 reads as zero, slai(0, imm)=0 for each word element.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Pattern A: rd_p = 0 — write suppressed, x1 unchanged
  #-------------------------------------------------------------

  # psslai.dw x0, x10, 1 with x10=0x11111111, x11=0x22222222
  # rd_p=0 means the write is suppressed; x1 must be untouched.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    TEST_VXSAT_CLEAR; \
    li x1, 0xdeadbeef; \
    li x10, 0x11111111; \
    li x11, 0x22222222; \
    psslai.dw x0, x10, 1 );

  #-------------------------------------------------------------
  # Pattern B: rs1_p = 0 — source reads as 0, slai(0, 1)=0
  #-------------------------------------------------------------

  # psslai.dw x14, x0, 1 — rs1_pair=(x0,x1)=(0,0), result=(0,0)
  TEST_CASE( 3, x14, 0x00000000, \
    TEST_VXSAT_CLEAR; \
    psslai.dw x14, x0, 1 );
  TEST_CASE( 4, x15, 0x00000000, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
