# See LICENSE for license details.

#*****************************************************************************
# pmqwacc_h.S
#-----------------------------------------------------------------------------
#
# Test pmqwacc_h instruction (packed Q-format widening multiply-accumulate halfword).
# Performs Q-format fixed-point multiply with accumulation on halfword operands.
# rd[31:0] = rd[31:0] + ((sext(rs1[15:0]) * sext(rs2[15:0])) >> 15)
# rd[63:32] = rd[63:32] + ((sext(rs1[31:16]) * sext(rs2[31:16])) >> 15)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic Q-format halfword multiply: 0.5 * 0.5 = 0.25 (lower), 0.5 * 0.5 = 0.25 (upper)
  # 0x4000 * 0x4000 >> 15 = 0x2000
  TEST_CASE( 2, x3, 0x00002000, \
    li  x3, 0x00000000; \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqwacc_h x3, x1, x2; \
  )

  # Accumulate to existing value: 0x1000 + (0x4000 * 0x4000 >> 15) = 0x3000
  TEST_CASE( 3, x3, 0x00003000, \
    li  x3, 0x00001000; \
    li  x1, 0x40004000; \
    li  x2, 0x40004000; \
    pmqwacc_h x3, x1, x2; \
  )

  # Negative Q-format: -0.5 * 0.5 = -0.25
  # 0xC000 * 0x4000 >> 15 = 0xE000
  TEST_CASE( 4, x3, 0xffffe000, \
    li  x3, 0x00000000; \
    li  x1, 0xC000C000; \
    li  x2, 0x40004000; \
    pmqwacc_h x3, x1, x2; \
  )

  # Both negative: -0.5 * -0.5 = 0.25
  # 0xC000 * 0xC000 >> 15 = 0x2000
  TEST_CASE( 5, x3, 0x00002000, \
    li  x3, 0x00000000; \
    li  x1, 0xC000C000; \
    li  x2, 0xC000C000; \
    pmqwacc_h x3, x1, x2; \
  )

  # Small values: 0.1 * 0.1 ≈ 0.01
  # 0x0CCD * 0x0CCD >> 15 ≈ 0x0106
  TEST_CASE( 6, x3, 0x00000106, \
    li  x3, 0x00000000; \
    li  x1, 0x0CCD0CCD; \
    li  x2, 0x0CCD0CCD; \
    pmqwacc_h x3, x1, x2; \
  )

  # Zero multiply: 0 * 0.5 = 0
  TEST_CASE( 7, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x40004000; \
    pmqwacc_h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

