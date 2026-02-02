# See LICENSE for license details.

#*****************************************************************************
# predsum_dhs.S
#-----------------------------------------------------------------------------
#
# Test predsum.dhs instruction (packed reduction sum signed double-halfword).
# Operates on 64-bit register pairs: rd = sum(rs1:rs1+1) as signed halfwords
# Sums all 4 signed halfwords from the 64-bit register pair
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum tests
  #-------------------------------------------------------------

  # Basic sum: 1+2+3+4 = 10
  TEST_CASE( 2, x14, 0x0000000a, \
    li  x11, 0x00020001; \
    li  x12, 0x00040003; \
    predsum.dhs x14, x11; \
  )

  # All zeros
  TEST_CASE( 3, x14, 0x00000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    predsum.dhs x14, x11; \
  )

  # All ones
  TEST_CASE( 4, x14, 0x00000004, \
    li  x11, 0x00010001; \
    li  x12, 0x00010001; \
    predsum.dhs x14, x11; \
  )

  # Negative values: -1 * 4 = -4
  TEST_CASE( 5, x14, 0xfffffffc, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    predsum.dhs x14, x11; \
  )

  # Mixed positive and negative: 100 + (-50) + 200 + (-100) = 150
  TEST_CASE( 6, x14, 0x00000096, \
    li  x11, 0xffce0064; \
    li  x12, 0xff3800c8; \
    predsum.dhs x14, x11; \
  )

  # Large positive values: 1000+1000+1000+1000 = 4000
  TEST_CASE( 7, x14, 0x00000fa0, \
    li  x11, 0x03e803e8; \
    li  x12, 0x03e803e8; \
    predsum.dhs x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

