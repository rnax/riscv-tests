# See LICENSE for license details.

#*****************************************************************************
# wzip16p.S
#-----------------------------------------------------------------------------
#
# Test wzip16p instruction (widening zip 16-bit elements to register-pair).
# Interleaves 16-bit elements from rs1 and rs2 into a 64-bit result.
# rd_pair = (rs2[15:0] << 16 | rs1[15:0]) | (rs2[31:16] << 48 | rs1[31:16] << 32)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wzip16p rd, rs1, rs2: interleaves 16-bit elements to 64-bit result
  #-------------------------------------------------------------

  # Basic: rs1=0x00000001, rs2=0x00000002 -> 0x0000000200000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000200000001, \
    li  x10, 0x00000001; \
    li  x12, 0x00000002; \
    wzip16p x14, x10, x12; \
  )

  # All zeros: rs1=0x00000000, rs2=0x00000000 -> 0x0000000000000000
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x12, 0x00000000; \
    wzip16p x14, x10, x12; \
  )

  # All ones: rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> 0xFFFFFFFFFFFFFFFF
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    li  x10, 0xffffffff; \
    li  x12, 0xffffffff; \
    wzip16p x14, x10, x12; \
  )

  # Pattern: rs1=0x12345678, rs2=0x9ABCDEF0
  TEST_CASE_D32( 5, x14, x15, 0x9abcdef012345678, \
    li  x10, 0x12345678; \
    li  x12, 0x9abcdef0; \
    wzip16p x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

