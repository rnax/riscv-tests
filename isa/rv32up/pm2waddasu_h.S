# See LICENSE for license details.

#*****************************************************************************
# pm2waddasu_h.S
#-----------------------------------------------------------------------------
#
# Test pm2waddasu.h instruction (packed 2-way signed*unsigned widening multiply-add accumulate halfword).
# Performs two 16-bit signed*unsigned multiplies and accumulates into 32-bit results.
# rd[31:0] = rd[31:0] + sext(rs1[15:0]) * zext(rs2[15:0])
# rd[63:32] = rd[63:32] + sext(rs1[31:16]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic signed*unsigned accumulate: rd=10, rs1=3, rs2=7, result=10+21=31 (lower)
  TEST_CASE( 2, x3, 0x0000001f, \
    li  x3, 0x0000000a; \
    li  x1, 0x00050003; \
    li  x2, 0x000b0007; \
    pm2waddasu.h x3, x1, x2; \
  )

  # Accumulate with larger values: rd=100, rs1=5, rs2=10, result=100+50=150
  TEST_CASE( 3, x3, 0x00000096, \
    li  x3, 0x00000064; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2waddasu.h x3, x1, x2; \
  )

  # Accumulate negative signed: rd=-10, rs1=-4, rs2=6, result=-10+(-24)=-34
  TEST_CASE( 4, x3, 0xffffffde, \
    li  x3, 0xfffffff6; \
    li  x1, 0xfffcfffc; \
    li  x2, 0x00060006; \
    pm2waddasu.h x3, x1, x2; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00000000; \
    pm2waddasu.h x3, x1, x2; \
  )

  # Accumulate with different operands: rd=50, rs1=5, rs2=10, result=50+50=100
  TEST_CASE( 6, x3, 0x00000064, \
    li  x3, 0x00000032; \
    li  x1, 0x00050005; \
    li  x2, 0x000a000a; \
    pm2waddasu.h x3, x1, x2; \
  )

  # Large signed*unsigned accumulate: rd=1000, rs1=100, rs2=100, result=1000+10000=11000
  TEST_CASE( 7, x3, 0x00002ae8, \
    li  x3, 0x000003e8; \
    li  x1, 0x00640064; \
    li  x2, 0x00640064; \
    pm2waddasu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

