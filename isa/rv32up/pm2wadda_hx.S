# See LICENSE for license details.

#*****************************************************************************
# pm2wadda_hx.S
#-----------------------------------------------------------------------------
#
# Test pm2wadda.hx instruction (packed 2-way widening multiply-add accumulate halfword cross).
# Performs cross-multiplies of 16-bit signed values and accumulates into 32-bit results.
# rd[31:0] = rd[31:0] + sext(rs1[15:0]) * sext(rs2[31:16])
# rd[63:32] = rd[63:32] + sext(rs1[31:16]) * sext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross accumulate: rd=10, rs1=3, rs2=11, result=10+33=43 (lower)
  TEST_CASE( 2, x3, 0x0000002b, \
    li  x3, 0x0000000a; \
    li  x1, 0x00050003; \
    li  x2, 0x000b0007; \
    pm2wadda.hx x3, x1, x2; \
  )

  # Accumulate with larger values: rd=100, rs1=5, rs2=14, result=100+70=170
  TEST_CASE( 3, x3, 0x000000aa, \
    li  x3, 0x00000064; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2wadda.hx x3, x1, x2; \
  )

  # Accumulate negative: rd=-10, rs1=-10, rs2=10, result=-10+(-100)=-110
  TEST_CASE( 4, x3, 0xffffff92, \
    li  x3, 0xfffffff6; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pm2wadda.hx x3, x1, x2; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00000000; \
    pm2wadda.hx x3, x1, x2; \
  )

  # Accumulate with different operands: rd=50, rs1=5, rs2=10, result=50+50=100
  TEST_CASE( 6, x3, 0x00000064, \
    li  x3, 0x00000032; \
    li  x1, 0x00050005; \
    li  x2, 0x000a000a; \
    pm2wadda.hx x3, x1, x2; \
  )

  # Large cross accumulate: rd=1000, rs1=100, rs2=100, result=1000+10000=11000
  TEST_CASE( 7, x3, 0x00002ae8, \
    li  x3, 0x000003e8; \
    li  x1, 0x00640064; \
    li  x2, 0x00640064; \
    pm2wadda.hx x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

