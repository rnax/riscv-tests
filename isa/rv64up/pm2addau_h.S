# See LICENSE for license details.

#*****************************************************************************
# pm2addau_h.S
#-----------------------------------------------------------------------------
#
# Test pm2addau.h instruction (packed 2-way unsigned multiply-add accumulate halfword).
# Performs two 16-bit unsigned multiplies and adds results to 32-bit accumulators.
# Accumulates into rd register.
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

  # Basic unsigned accumulate: 100 + 3 * 7 = 121 (lower), 200 + 5 * 11 = 255 (upper)
  TEST_CASE( 2, x3, 0x000000ff, \
    li  x3, 0x000000c8; \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm2addau.h x3, x1, x2; \
  )

  # Multiple unsigned accumulations: 50 + 5 * 10 = 100 (lower), 75 + 7 * 14 = 173 (upper)
  TEST_CASE( 3, x3, 0x000000ad, \
    li  x3, 0x0000004b; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2addau.h x3, x1, x2; \
  )

  # Large unsigned accumulate: 1000 + 0xffff * 0xffff = 0xfffe1001 (lower)
  TEST_CASE( 4, x3, 0xfffe1001, \
    li  x3, 0x000003e8; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pm2addau.h x3, x1, x2; \
  )

  # Mixed unsigned accumulate: 2000 + 0x8000 * 0x8000 = 0x400007d0 (lower)
  TEST_CASE( 5, x3, 0x400007d0, \
    li  x3, 0x000007d0; \
    li  x1, 0x80008000; \
    li  x2, 0x80008000; \
    pm2addau.h x3, x1, x2; \
  )

  # Zero unsigned accumulate: 500 + 0 * 100 = 500 (lower), 600 + 0 * 200 = 600 (upper)
  TEST_CASE( 6, x3, 0x00000258, \
    li  x3, 0x00000258; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2addau.h x3, x1, x2; \
  )

  # Large unsigned accumulate: 1000 + 0xfffe * 0xfffe = 0xfffc1004 (lower)
  TEST_CASE( 7, x3, 0xfffc1004, \
    li  x3, 0x000003e8; \
    li  x1, 0xfffeffff; \
    li  x2, 0xfffeffff; \
    pm2addau.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

