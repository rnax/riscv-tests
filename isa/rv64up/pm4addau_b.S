# See LICENSE for license details.

#*****************************************************************************
# pm4addau_b.S
#-----------------------------------------------------------------------------
#
# Test pm4addau.b instruction (packed 4-way unsigned multiply-add accumulate byte).
# Performs four 8-bit unsigned multiplies and adds results to 16-bit accumulators.
# Accumulates into rd register.
# rd[15:0] = rd[15:0] + zext(rs1[7:0]) * zext(rs2[7:0])
# rd[31:16] = rd[31:16] + zext(rs1[15:8]) * zext(rs2[15:8])
# rd[47:32] = rd[47:32] + zext(rs1[23:16]) * zext(rs2[23:16])
# rd[63:48] = rd[63:48] + zext(rs1[31:24]) * zext(rs2[31:24])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 4-way unsigned accumulate: 10 + 3*7 = 31, 20 + 5*11 = 75, 30 + 2*4 = 38, 40 + 6*3 = 58
  TEST_CASE( 2, x3, 0x003a0026, \
    li  x3, 0x0028001e; \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addau.b x3, x1, x2; \
  )

  # Multiple 4-way unsigned accumulations: 50 + 3*7 = 71, 75 + 5*11 = 130, 100 + 2*4 = 108, 125 + 6*3 = 143
  TEST_CASE( 3, x3, 0x008f006c, \
    li  x3, 0x007d0064; \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addau.b x3, x1, x2; \
  )

  # Large unsigned accumulate: 1000 + 0xff*0xff = 0xfe01 + 1000 = 0x10de1 (lower)
  TEST_CASE( 4, x3, 0x10de10de, \
    li  x3, 0x03e803e8; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pm4addau.b x3, x1, x2; \
  )

  # Mixed unsigned accumulate: 2000 + 0x80*0x80 = 0x4000 + 2000 = 0x43e8 (lower)
  TEST_CASE( 5, x3, 0x43e843e8, \
    li  x3, 0x07d007d0; \
    li  x1, 0x80808080; \
    li  x2, 0x80808080; \
    pm4addau.b x3, x1, x2; \
  )

  # Zero unsigned accumulate: 500 + 0*100 = 500 (all bytes)
  TEST_CASE( 6, x3, 0x01f401f4, \
    li  x3, 0x01f401f4; \
    li  x1, 0x00000000; \
    li  x2, 0x64646464; \
    pm4addau.b x3, x1, x2; \
  )

  # Large unsigned accumulate: 1000 + 0xfe*0xfe = 0xfc04 + 1000 = 0x10e08 (lower)
  TEST_CASE( 7, x3, 0x10e010e0, \
    li  x3, 0x03e803e8; \
    li  x1, 0xfefefefe; \
    li  x2, 0xfefefefe; \
    pm4addau.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

