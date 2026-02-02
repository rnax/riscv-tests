# See LICENSE for license details.

#*****************************************************************************
# predsum_dbs.S
#-----------------------------------------------------------------------------
#
# Test predsum.dbs instruction (packed reduction sum signed double-byte).
# Operates on 64-bit register pairs: rd = sum(rs1:rs1+1) as signed bytes
# Sums all 8 signed bytes from the 64-bit register pair
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum tests
  #-------------------------------------------------------------

  # Basic sum: 1+2+3+4+5+6+7+8 = 36
  TEST_CASE( 2, x14, 0x00000024, \
    li  x11, 0x04030201; \
    li  x12, 0x08070605; \
    predsum.dbs x14, x11; \
  )

  # All zeros
  TEST_CASE( 3, x14, 0x00000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    predsum.dbs x14, x11; \
  )

  # All ones
  TEST_CASE( 4, x14, 0x00000008, \
    li  x11, 0x01010101; \
    li  x12, 0x01010101; \
    predsum.dbs x14, x11; \
  )

  # Negative values: -1 * 8 = -8
  TEST_CASE( 5, x14, 0xfffffff8, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    predsum.dbs x14, x11; \
  )

  # Mixed positive and negative: 10 + (-5) + 20 + (-10) + 5 + (-2) + 15 + (-8) = 25
  TEST_CASE( 6, x14, 0x00000019, \
    li  x11, 0xfbfb0a0a; \
    li  x12, 0xf80f0514; \
    predsum.dbs x14, x11; \
  )

  # Large positive values: 100+100+100+100+100+100+100+100 = 800
  TEST_CASE( 7, x14, 0x00000320, \
    li  x11, 0x64646464; \
    li  x12, 0x64646464; \
    predsum.dbs x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

