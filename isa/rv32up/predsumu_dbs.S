# See LICENSE for license details.

#*****************************************************************************
# predsumu_dbs.S
#-----------------------------------------------------------------------------
#
# Test predsumu.dbs instruction (packed reduction sum unsigned double-byte).
# Operates on 64-bit register pairs: rd = sum(rs1:rs1+1) as unsigned bytes
# Sums all 8 unsigned bytes from the 64-bit register pair
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
    predsumu.dbs x14, x11; \
  )

  # All zeros
  TEST_CASE( 3, x14, 0x00000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    predsumu.dbs x14, x11; \
  )

  # All ones (255 each)
  TEST_CASE( 4, x14, 0x000007f8, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    predsumu.dbs x14, x11; \
  )

  # Large values: 200+200+200+200+200+200+200+200 = 1600
  TEST_CASE( 5, x14, 0x00000640, \
    li  x11, 0xc8c8c8c8; \
    li  x12, 0xc8c8c8c8; \
    predsumu.dbs x14, x11; \
  )

  # Mixed values: 100+50+150+75+200+25+100+50 = 750
  TEST_CASE( 6, x14, 0x000002ee, \
    li  x11, 0x4b964b64; \
    li  x12, 0x32c81964; \
    predsumu.dbs x14, x11; \
  )

  # High byte values: 255+254+253+252+251+250+249+248 = 2012
  TEST_CASE( 7, x14, 0x000007dc, \
    li  x11, 0xfcfdfeff; \
    li  x12, 0xf8f9fafb; \
    predsumu.dbs x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

