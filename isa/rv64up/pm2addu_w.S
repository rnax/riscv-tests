# See LICENSE for license details.

#*****************************************************************************
# pm2addu_w.S
#-----------------------------------------------------------------------------
#
# Test pm2addu.w instruction (packed 2-way unsigned multiply-add word).
# Performs two 32-bit unsigned multiplies and adds results to 64-bit accumulators.
# rd[63:0] = rd[63:0] + zext(rs1[31:0]) * zext(rs2[31:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned multiply-add: 0 + 3 * 7 = 21
  TEST_CASE( 2, x3, 0x0000000000000015, \
    li  x1, 0x0000000000000003; \
    li  x2, 0x0000000000000007; \
    pm2addu.w x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_CASE( 3, x3, 0x0000000000000096, \
    li  x3, 0x0000000000000064; \
    li  x1, 0x0000000000000005; \
    li  x2, 0x000000000000000a; \
    pm2addu.w x3, x1, x2; \
  )

  # Large unsigned values: 0 + 0xffffffff * 0xffffffff = 0xfffffffe00000001
  TEST_CASE( 4, x3, 0xfffffffe00000001, \
    li  x1, 0x00000000ffffffff; \
    li  x2, 0x00000000ffffffff; \
    pm2addu.w x3, x1, x2; \
  )

  # Mixed unsigned: 0 + 0x80000000 * 0x80000000 = 0x4000000000000000
  TEST_CASE( 5, x3, 0x4000000000000000, \
    li  x1, 0x0000000080000000; \
    li  x2, 0x0000000080000000; \
    pm2addu.w x3, x1, x2; \
  )

  # Zero multiply: 0 + 0 * 100 = 0
  TEST_CASE( 6, x3, 0x0000000000000000, \
    li  x3, 0x0000000000000000; \
    li  x1, 0x0000000000000000; \
    li  x2, 0x0000000000000064; \
    pm2addu.w x3, x1, x2; \
  )

  # Accumulate large: 0x1000000000000000 + 0x100 * 0x100 = 0x1000000000010000
  TEST_CASE( 7, x3, 0x1000000000010000, \
    li  x3, 0x1000000000000000; \
    li  x1, 0x0000000000000100; \
    li  x2, 0x0000000000000100; \
    pm2addu.w x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

