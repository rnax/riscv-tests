# See LICENSE for license details.

#*****************************************************************************
# pm2addu_h.S
#-----------------------------------------------------------------------------
#
# Test pm2addu.h instruction (packed 2-way unsigned multiply-add halfword).
# Performs two 16-bit unsigned multiplies and adds results to 32-bit accumulators.
# rd[31:0] = rd[31:0] + zext(rs1[15:0]) * zext(rs2[15:0])
# rd[63:32] = rd[63:32] + zext(rs1[31:16]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned multiply-add: 0 + 3 * 7 = 21 (lower), 0 + 5 * 11 = 55 (upper)
  TEST_CASE( 2, x3, 0x00000015, \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm2addu.h x3, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150 (lower), 200 + 7 * 14 = 298 (upper)
  TEST_CASE( 3, x3, 0x0000012a, \
    li  x3, 0x000000c8; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2addu.h x3, x1, x2; \
  )

  # Large unsigned multiply: 0 + 0xffff * 0xffff = 0xfffe0001 (lower)
  TEST_CASE( 4, x3, 0xfffe0001, \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pm2addu.h x3, x1, x2; \
  )

  # Mixed unsigned values: 0 + 0x8000 * 0x8000 = 0x40000000 (lower)
  TEST_CASE( 5, x3, 0x40000000, \
    li  x1, 0x80008000; \
    li  x2, 0x80008000; \
    pm2addu.h x3, x1, x2; \
  )

  # Zero unsigned multiply: 0 + 0 * 100 = 0 (lower), 0 + 0 * 200 = 0 (upper)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2addu.h x3, x1, x2; \
  )

  # Large unsigned values: 0 + 0xfffe * 0xfffe = 0xfffc0004 (lower)
  TEST_CASE( 7, x3, 0xfffc0004, \
    li  x1, 0xfffeffff; \
    li  x2, 0xfffeffff; \
    pm2addu.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

