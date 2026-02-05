# See LICENSE for license details.

#*****************************************************************************
# pm4addu_b.S
#-----------------------------------------------------------------------------
#
# Test pm4addu.b instruction (packed 4-way unsigned multiply-add byte).
# Performs four 8-bit unsigned multiplies and adds results to 16-bit accumulators.
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

  # Basic 4-way unsigned multiply-add: 0 + 3*7 = 21, 0 + 5*11 = 55, 0 + 2*4 = 8, 0 + 6*3 = 18
  TEST_CASE( 2, x3, 0x00120008, \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addu.b x3, x1, x2; \
  )

  # Accumulate to existing values: 10 + 3*7 = 31, 20 + 5*11 = 75, 30 + 2*4 = 38, 40 + 6*3 = 58
  TEST_CASE( 3, x3, 0x003a0026, \
    li  x3, 0x0028001e; \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addu.b x3, x1, x2; \
  )

  # Large unsigned multiply: 0 + 0xff*0xff = 0xfe01, 0 + 0xff*0xff = 0xfe01, etc.
  TEST_CASE( 4, x3, 0xfe01fe01, \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    pm4addu.b x3, x1, x2; \
  )

  # Mixed unsigned values: 0 + 0x80*0x80 = 0x4000, 0 + 0x80*0x80 = 0x4000, etc.
  TEST_CASE( 5, x3, 0x40004000, \
    li  x1, 0x80808080; \
    li  x2, 0x80808080; \
    pm4addu.b x3, x1, x2; \
  )

  # Zero unsigned multiply: 0 + 0*100 = 0 (all bytes)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x64646464; \
    pm4addu.b x3, x1, x2; \
  )

  # Large unsigned values: 0 + 0xfe*0xfe = 0xfc04, 0 + 0xfe*0xfe = 0xfc04, etc.
  TEST_CASE( 7, x3, 0xfc04fc04, \
    li  x1, 0xfefefefe; \
    li  x2, 0xfefefefe; \
    pm4addu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

