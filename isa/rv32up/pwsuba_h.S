# See LICENSE for license details.

#*****************************************************************************
# pwsuba_h.S
#-----------------------------------------------------------------------------
#
# Test pwsuba.h instruction (packed widening signed subtract accumulate halfword).
# Subtracts two 16-bit signed values and accumulates into 32-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: rd=10, rs1=10, rs2=4, result=10+(10-4)=16
  TEST_CASE( 2, x3, 0x00000010, \
    li  x3, 0x0000000a; \
    li  x1, 0x000a0000; \
    li  x2, 0x00040000; \
    pwsuba.h x3, x1, x2; \
  )

  # Accumulate with negative result: rd=10, rs1=4, rs2=10, result=10+(4-10)=4
  TEST_CASE( 3, x3, 0x00000004, \
    li  x3, 0x0000000a; \
    li  x1, 0x00040000; \
    li  x2, 0x000a0000; \
    pwsuba.h x3, x1, x2; \
  )

  # Accumulate negative: rd=-10, rs1=-4, rs2=-6, result=-10+(-4-(-6))=-8
  TEST_CASE( 4, x3, 0xfffffff8, \
    li  x3, 0xfffffff6; \
    li  x1, 0xfffc0000; \
    li  x2, 0xfffa0000; \
    pwsuba.h x3, x1, x2; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00000000; \
    pwsuba.h x3, x1, x2; \
  )

  # Accumulate with different operands: rd=5, rs1=20, rs2=10, result=5+(20-10)=15
  TEST_CASE( 6, x3, 0x0000000f, \
    li  x3, 0x00000005; \
    li  x1, 0x00140000; \
    li  x2, 0x000a0000; \
    pwsuba.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

