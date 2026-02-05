# See LICENSE for license details.

#*****************************************************************************
# pm4addasu_b.S
#-----------------------------------------------------------------------------
#
# Test pm4addasu.b instruction (packed 4-way signed*unsigned multiply-add accumulate byte).
# Performs four 8-bit signed*unsigned multiplies and adds results to 16-bit accumulators.
# Accumulates into rd register.
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

  # Basic 4-way signed*unsigned accumulate: 10 + 3*7 = 31, 20 + 5*11 = 75, 30 + 2*4 = 38, 40 + 6*3 = 58
  TEST_CASE( 2, x3, 0x003a0026, \
    li  x3, 0x0028001e; \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addasu.b x3, x1, x2; \
  )

  # Multiple 4-way signed*unsigned accumulations: 50 + 3*7 = 71, 75 + 5*11 = 130, 100 + 2*4 = 108, 125 + 6*3 = 143
  TEST_CASE( 3, x3, 0x008f006c, \
    li  x3, 0x007d0064; \
    li  x1, 0x06020503; \
    li  x2, 0x030b0407; \
    pm4addasu.b x3, x1, x2; \
  )

  # Negative signed with unsigned accumulate: 500 + (-10)*20 = 300, 600 + (-5)*10 = 550, 700 + 4*(-3) = 688, 800 + 2*(-4) = 792
  TEST_CASE( 4, x3, 0x031802b0, \
    li  x3, 0x03200300; \
    li  x1, 0x02fc0ff6; \
    li  x2, 0xfd0a140c; \
    pm4addasu.b x3, x1, x2; \
  )

  # Mixed signs accumulate: 1000 + (-4)*6 = 976, 2000 + 8*(-3) = 1976, 3000 + 2*5 = 3010, 4000 + (-1)*7 = 3993
  TEST_CASE( 5, x3, 0x0fa80bc2, \
    li  x3, 0x0fa80bc8; \
    li  x1, 0xfffe0208; \
    li  x2, 0x05fdfffe; \
    pm4addasu.b x3, x1, x2; \
  )

  # Zero signed*unsigned accumulate: 500 + 0*100 = 500 (all bytes)
  TEST_CASE( 6, x3, 0x01f401f4, \
    li  x3, 0x01f401f4; \
    li  x1, 0x00000000; \
    li  x2, 0x64646464; \
    pm4addasu.b x3, x1, x2; \
  )

  # Large signed*unsigned accumulate: 1000 + 0x7f*0xff = 0x7e81 + 1000 = 0x81e1 (lower)
  TEST_CASE( 7, x3, 0x81e181e1, \
    li  x3, 0x03e803e8; \
    li  x1, 0x7f7f7f7f; \
    li  x2, 0xffffffff; \
    pm4addasu.b x3, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

