# See LICENSE for license details.

#*****************************************************************************
# pm2adda_h.S
#-----------------------------------------------------------------------------
#
# Test pm2adda.h instruction (packed 2-way multiply-add accumulate halfword).
# Performs two 16-bit signed multiplies and adds results to 32-bit accumulators.
# Accumulates into rd register.
# rd[31:0] = rd[31:0] + sext(rs1[15:0]) * sext(rs2[15:0])
# rd[63:32] = rd[63:32] + sext(rs1[31:16]) * sext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: 100 + 3 * 7 = 121 (lower), 200 + 5 * 11 = 255 (upper)
  TEST_CASE( 2, x3, 0x000000ff, \
    li  x3, 0x000000c8; \
    li  x1, 0x000b0003; \
    li  x2, 0x000b0007; \
    pm2adda.h x3, x1, x2; \
  )

  # Multiple accumulations: 50 + 5 * 10 = 100 (lower), 75 + 7 * 14 = 173 (upper)
  TEST_CASE( 3, x3, 0x000000ad, \
    li  x3, 0x0000004b; \
    li  x1, 0x00070005; \
    li  x2, 0x000e000a; \
    pm2adda.h x3, x1, x2; \
  )

  # Negative accumulate: 500 + (-10) * 20 = 300 (lower), 600 + (-5) * 10 = 550 (upper)
  TEST_CASE( 4, x3, 0x00000226, \
    li  x3, 0x00000258; \
    li  x1, 0xfffbfff6; \
    li  x2, 0x000a0014; \
    pm2adda.h x3, x1, x2; \
  )

  # Mixed signs accumulate: 1000 + (-4) * 6 = 976 (lower), 2000 + 8 * (-3) = 1976 (upper)
  TEST_CASE( 5, x3, 0x000007b8, \
    li  x3, 0x000007d0; \
    li  x1, 0xfffcfffc; \
    li  x2, 0xfffdfffe; \
    pm2adda.h x3, x1, x2; \
  )

  # Zero accumulate: 500 + 0 * 100 = 500 (lower), 600 + 0 * 200 = 600 (upper)
  TEST_CASE( 6, x3, 0x00000258, \
    li  x3, 0x00000258; \
    li  x1, 0x00000000; \
    li  x2, 0x00640064; \
    pm2adda.h x3, x1, x2; \
  )

  # Large accumulate: 1000 + 0x7fff * 0x7fff = 0x3fff1001 (lower)
  TEST_CASE( 7, x3, 0x3fff1001, \
    li  x3, 0x000003e8; \
    li  x1, 0x7fff7fff; \
    li  x2, 0x7fff7fff; \
    pm2adda.h x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

