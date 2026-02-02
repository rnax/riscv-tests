# See LICENSE for license details.

#*****************************************************************************
# predsumu_dhs.S
#-----------------------------------------------------------------------------
#
# Test predsumu.dhs instruction (packed reduction sum unsigned double-halfword).
# Operates on 64-bit register pairs: rd = sum(rs1:rs1+1) as unsigned halfwords
# Sums all 4 unsigned halfwords from the 64-bit register pair
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
    predsumu.dhs x14, x11; \
  )

  # All zeros
  TEST_CASE( 3, x14, 0x00000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    predsumu.dhs x14, x11; \
  )

  # All ones (65535 each)
  TEST_CASE( 4, x14, 0x0000fffc, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    predsumu.dhs x14, x11; \
  )

  # Large values: 10000+10000+10000+10000 = 40000
  TEST_CASE( 5, x14, 0x00009c40, \
    li  x11, 0x27102710; \
    li  x12, 0x27102710; \
    predsumu.dhs x14, x11; \
  )

  # Mixed values: 1000+2000+3000+4000 = 10000
  TEST_CASE( 6, x14, 0x00002710, \
    li  x11, 0x07d003e8; \
    li  x12, 0x0fa80bb8; \
    predsumu.dhs x14, x11; \
  )

  # High halfword values: 65000+64000+63000+62000 = 254000
  TEST_CASE( 7, x14, 0x0003e0d0, \
    li  x11, 0xf9c0fde8; \
    li  x12, 0xf1a0f5e8; \
    predsumu.dhs x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

