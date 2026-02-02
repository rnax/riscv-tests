# See LICENSE for license details.

#*****************************************************************************
# pwadda_b.S
#-----------------------------------------------------------------------------
#
# Test pwadda.b instruction (packed widening signed add accumulate byte).
# Adds two 8-bit signed values and accumulates into 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: rd=10, rs1=4, rs2=6, result=10+10=20 (0x0014 in both bytes)
  TEST_CASE( 2, x3, 0x00140014, \
    li  x3, 0x000a000a; \
    li  x1, 0x04060406; \
    pwadda.b x3, x1, x1; \
  )

  # Accumulate with larger values: rd=0x00fe, rs1=0x7f, rs2=0x7f, result=0x00fe+0x00fe=0x01fc
  TEST_CASE( 3, x3, 0x01fc01fc, \
    li  x3, 0x00fe00fe; \
    li  x1, 0x7f7f7f7f; \
    pwadda.b x3, x1, x1; \
  )

  # Accumulate negative: rd=-10, rs1=-4, rs2=-6, result=-10+(-10)=-20 (0xffec)
  TEST_CASE( 4, x3, 0xffecffec, \
    li  x3, 0xfff6fff6; \
    li  x1, 0xfcfafcfa; \
    pwadda.b x3, x1, x1; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    pwadda.b x3, x1, x1; \
  )

  # Accumulate with different operands: rd=10, rs1=5, rs2=15, result=10+20=30
  TEST_CASE( 6, x3, 0x001e001e, \
    li  x3, 0x000a000a; \
    li  x1, 0x050f050f; \
    pwadda.b x3, x1, x1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

