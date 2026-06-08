# See LICENSE for license details.

#*****************************************************************************
# psext_dw_b_p0.S
#-----------------------------------------------------------------------------
#
# Test psext.dw.b zero-pair constraint.
# Pattern A: rd_p=0 suppresses the write.
# Pattern B: rs1_p=0 reads as zero, sext8(0)=0 for each word element.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Pattern A: rd_p = 0 — write suppressed, x1 unchanged
  #-------------------------------------------------------------

  # psext.dw.b x0, x10 with x10=0x01020304, x11=0x05060708
  # rd_p=0 means the write is suppressed; x1 must be untouched.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    li x1, 0xdeadbeef; \
    li x10, 0x01020304; \
    li x11, 0x05060708; \
    psext.dw.b x0, x10 );

  #-------------------------------------------------------------
  # Pattern B: rs1_p = 0 — source reads as 0, sext8(0)=0
  #-------------------------------------------------------------

  # psext.dw.b x14, x0 — rs1_pair=(x0,x1)=(0,0), result=(0,0)
  TEST_CASE( 3, x14, 0x00000000, \
    psext.dw.b x14, x0 );
  TEST_CASE( 4, x15, 0x00000000, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
