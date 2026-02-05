# See LICENSE for license details.

#*****************************************************************************
# pm2sadd_h.S
#-----------------------------------------------------------------------------
#
# Test pm2sadd.h instruction (packed 2-way saturating multiply-add halfword).
# Performs two 16-bit signed multiplies and adds results to 32-bit accumulators with saturation.
# rd[31:0] = sat(rd[31:0] + sext(rs1[15:0]) * sext(rs2[15:0]))
# rd[63:32] = sat(rd[63:32] + sext(rs1[31:16]) * sext(rs2[31:16]))
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic saturating multiply-add: 0 + 3 * 7 = 21 (lower), 0 + 5 * 11 = 55 (upper)
  TEST_CASE( 2, x3, 0x00000015, \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm2sadd.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150 (lower), 200 + 7 * 14 = 298 (upper)
  TEST_CASE( 3, x3, 0x0000012a, \
    li  x3, 0x000000c8; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2sadd.h x3, x1, x2; \
  )

  # Saturate positive: 0x7fffffff + 0x7fff * 0x7fff = 0x7fffffff (saturated)
  TEST_CASE( 4, x3, 0x7fffffff, \
    li  x3, 0x7fffffff; \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm2sadd.h x3, x1, x2; \
  )

  # Saturate negative: 0x80000000 + (-0x8000) * (-0x8000) = 0x80000000 (saturated)
  TEST_CASE( 5, x3, 0x80000000, \
    li  x3, 0x80000000; \
    li  x1, 0x80008000; \
    li  x2, 0x80008000; \
    pm2sadd.h x3, x1, x2; \
  )

  # Zero saturating multiply: 0 + 0 * 100 = 0 (lower), 0 + 0 * 200 = 0 (upper)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2sadd.h x3, x1, x2; \
  )

  # Mixed saturate: 0 + (-10) * 20 = -200 (lower), 0 + (-5) * 10 = -50 (upper)
  TEST_CASE( 7, x3, 0xffffcf38, \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pm2sadd.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

