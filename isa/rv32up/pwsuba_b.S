# See LICENSE for license details.

#*****************************************************************************
# pwsuba_b.S
#-----------------------------------------------------------------------------
#
# Test pwsuba.b instruction (packed widening signed subtract accumulate byte).
# Subtracts two 8-bit signed values and accumulates into 16-bit signed results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: rd=10, rs1=10, rs2=4, result=10+(10-4)=16 (0x0010 in both bytes)
  TEST_CASE( 2, x3, 0x00100010, \
    li  x3, 0x000a000a; \
    li  x1, 0x0a0a0a0a; \
    li  x2, 0x04040404; \
    pwsuba.b x3, x1, x2; \
  )

  # Accumulate with negative result: rd=10, rs1=4, rs2=10, result=10+(4-10)=4 (0x0004 in both bytes)
  TEST_CASE( 3, x3, 0x00040004, \
    li  x3, 0x000a000a; \
    li  x1, 0x04040404; \
    li  x2, 0x0a0a0a0a; \
    pwsuba.b x3, x1, x2; \
  )

  # Accumulate negative: rd=-10, rs1=-4, rs2=-6, result=-10+(-4-(-6))=-8 (0xfff8)
  TEST_CASE( 4, x3, 0xfff8fff8, \
    li  x3, 0xfff6fff6; \
    li  x1, 0xfcfcfcfc; \
    li  x2, 0xfafafafa; \
    pwsuba.b x3, x1, x2; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00000000; \
    pwsuba.b x3, x1, x2; \
  )

  # Accumulate with different operands: rd=5, rs1=20, rs2=10, result=5+(20-10)=15
  TEST_CASE( 6, x3, 0x000f000f, \
    li  x3, 0x00050005; \
    li  x1, 0x14141414; \
    li  x2, 0x0a0a0a0a; \
    pwsuba.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

