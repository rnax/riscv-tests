# See LICENSE for license details.

#*****************************************************************************
# pm4add_h.S
#-----------------------------------------------------------------------------
#
# Test pm4add.h instruction (packed 4-way multiply-add halfword).
# Performs four 16-bit signed multiplies and adds results to 32-bit accumulators.
# rd[31:0] = rd[31:0] + sext(rs1[15:0]) * sext(rs2[15:0])
# rd[63:32] = rd[63:32] + sext(rs1[31:16]) * sext(rs2[31:16])
# Note: This is a 4-way operation on 64-bit register (two 16-bit multiplies per half)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 4-way multiply-add: 0 + 3*7 = 21 (lower), 0 + 5*11 = 55 (upper)
  TEST_CASE( 2, x3, 0x0000003700000015, \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm4add.h x3, x1, x2; \
  )

  # Accumulate to existing values: 100 + 5*10 = 150 (lower), 200 + 7*14 = 298 (upper)
  TEST_CASE( 3, x3, 0x000001320000009600, \
    li  x3, 0x000000c8; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm4add.h x3, x1, x2; \
  )

  # Negative multiply: 0 + (-10)*20 = -200 (lower), 0 + (-5)*10 = -50 (upper)
  TEST_CASE( 4, x3, 0xffffcf38, \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pm4add.h x3, x1, x2; \
  )

  # Mixed signs: 0 + (-4)*6 = -24 (lower), 0 + 8*(-3) = -24 (upper)
  TEST_CASE( 5, x3, 0xffffffe8, \
    li  x1, 0xfffcfffc; \
    li  x2, 0xfffdfffe; \
    pm4add.h x3, x1, x2; \
  )

  # Zero multiply: 0 + 0*100 = 0 (all)
  TEST_CASE( 6, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000006400000064; \
    pm4add.h x3, x1, x2; \
  )

  # Large values: 0 + 0x7fff*0x7fff = 0x3fff0001 (lower)
  TEST_CASE( 7, x3, 0x3fff00013fff0001, \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm4add.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

