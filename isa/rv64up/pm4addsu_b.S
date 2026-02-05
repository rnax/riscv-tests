# See LICENSE for license details.

#*****************************************************************************
# pm4addsu_b.S
#-----------------------------------------------------------------------------
#
# Test pm4addsu.b instruction (packed 4-way signed*unsigned multiply-add byte).
# Performs four 8-bit signed*unsigned multiplies and adds results to 16-bit accumulators.
# rd[15:0] = rd[15:0] + sext(rs1[7:0]) * zext(rs2[7:0])
# rd[31:16] = rd[31:16] + sext(rs1[15:8]) * zext(rs2[15:8])
# rd[47:32] = rd[47:32] + sext(rs1[23:16]) * zext(rs2[23:16])
# rd[63:48] = rd[63:48] + sext(rs1[31:24]) * zext(rs2[31:24])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 4-way signed*unsigned multiply-add: 0 + 3*7 = 21, 0 + 5*11 = 55, 0 + 2*4 = 8, 0 + 6*3 = 18
  TEST_CASE( 2, x3, 0x00120008, \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addsu.b x3, x1, x2; \
  )

  # Accumulate to existing values: 10 + 3*7 = 31, 20 + 5*11 = 75, 30 + 2*4 = 38, 40 + 6*3 = 58
  TEST_CASE( 3, x3, 0x003a0026, \
    li  x3, 0x0028001e; \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addsu.b x3, x1, x2; \
  )

  # Negative signed with unsigned: 0 + (-10)*20 = -200, 0 + (-5)*10 = -50, 0 + 4*(-3) = -12, 0 + 2*(-4) = -8
  TEST_CASE( 4, x3, 0xfff8fff4, \
    li  x1, 0x02fc0ff6; \
    li  x2, 0xfd0a140c; \
    pm4addsu.b x3, x1, x2; \
  )

  # Mixed signs: 0 + (-4)*6 = -24, 0 + 8*(-3) = -24, 0 + 2*5 = 10, 0 + (-1)*7 = -7
  TEST_CASE( 5, x3, 0xfff90a00, \
    li  x1, 0xfffe0208; \
    li  x2, 0x05fdfffe; \
    pm4addsu.b x3, x1, x2; \
  )

  # Zero signed*unsigned multiply: 0 + 0*100 = 0 (all bytes)
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    li  x2, 0x64646464; \
    pm4addsu.b x3, x1, x2; \
  )

  # Large signed*unsigned: 0 + 0x7f*0xff = 0x7e81, 0 + 0x7f*0xff = 0x7e81, etc.
  TEST_CASE( 7, x3, 0x7e817e81, \
    li  x1, 0x7f7f7f7f; \
    li  x2, 0xffffffff; \
    pm4addsu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

