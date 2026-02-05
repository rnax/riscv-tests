# See LICENSE for license details.

#*****************************************************************************
# pmq2add_h.S
#-----------------------------------------------------------------------------
#
# Test pmq2add.h instruction (packed Q-format 2-way multiply-add halfword).
# Performs two 16-bit Q-format multiplies and adds results to 32-bit accumulators.
# rd[31:0] = (sext(rs1[15:0]) * sext(rs2[15:0])) >> 15
# rd[63:32] = (sext(rs1[31:16]) * sext(rs2[31:16])) >> 15
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format multiply: 0.5 * 0.5 = 0.25
  # 0x4000 (Q15: 0.5) * 0x4000 (Q15: 0.5) >> 15 = 0x4000 (Q15: 0.5)
  TEST_CASE( 2, x3, 0x00004000, \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmq2add.h x3, x1, x2; \
  )

  # Negative Q-format: -0.5 * 0.5 = -0.25
  # 0xC000 (Q15: -0.5) * 0x4000 (Q15: 0.5) >> 15 = 0xC000 (Q15: -0.5)
  TEST_CASE( 3, x3, 0xffffc000, \
    li  x1, 0xC000C000; \
    li  x2, 0x40004000; \
    pmq2add.h x3, x1, x2; \
  )

  # Both negative: -0.5 * -0.5 = 0.25
  # 0xC000 * 0xC000 >> 15 = 0x4000
  TEST_CASE( 4, x3, 0x00004000, \
    li  x1, 0xC000C000; \
    li  x2, 0xC000C000; \
    pmq2add.h x3, x1, x2; \
  )

  # Small values: 0.1 * 0.1 ≈ 0.01
  # 0x0CCD (Q15: ~0.1) * 0x0CCD >> 15 ≈ 0x0106 (Q15: ~0.01)
  TEST_CASE( 5, x3, 0x00000106, \
    li  x1, 0x0CCD0CCD; \
    li  x2, 0x0CCD0CCD; \
    pmq2add.h x3, x1, x2; \
  )

  # Zero multiply: 0 * 0.5 = 0
  TEST_CASE( 6, x3, 0x00000000, \
    li  x1, 0x00000000; \
    li  x2, 0x40004000; \
    pmq2add.h x3, x1, x2; \
  )

  # One (Q15: 0x7FFF) * 0.5 = 0.5
  # 0x7FFF * 0x4000 >> 15 = 0x3FFF
  TEST_CASE( 7, x3, 0x00003fff, \
    li  x1, 0x7FFF7FFF; \
    li  x2, 0x40004000; \
    pmq2add.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

