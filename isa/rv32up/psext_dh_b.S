# See LICENSE for license details.

#*****************************************************************************
# psext_dh_b.S
#-----------------------------------------------------------------------------
#
# Test psext.dh.b instruction (packed sign-extend byte to double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = sign_extend(rs1:rs1+1 bytes to halfwords)
# 4 elements of 8-bits extended to 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive byte: 0x42 -> 0x0042
  TEST_CASE_D32( 2, x14, x15, 0x00420042, \
    li  x11, 0x42424242; \
    li  x12, 0x00000000; \
    psext.dh.b x14, x11; \
  )

  # Negative byte: 0x80 -> 0xff80
  TEST_CASE_D32( 3, x14, x15, 0xff80ff80ff80ff80, \
    li  x11, 0x80808080; \
    li  x12, 0xffffffff; \
    psext.dh.b x14, x11; \
  )

  # Zero: 0x00 -> 0x0000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    psext.dh.b x14, x11; \
  )

  # Max positive: 0x7f -> 0x007f
  TEST_CASE_D32( 5, x14, x15, 0x007f007f007f007f, \
    li  x11, 0x7f7f7f7f; \
    li  x12, 0x00000000; \
    psext.dh.b x14, x11; \
  )

  # Min negative: 0xff -> 0xffff
  TEST_CASE_D32( 6, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    psext.dh.b x14, x11; \
  )

  # Mixed: 0x01 -> 0x0001, 0xff -> 0xffff
  TEST_CASE_D32( 7, x14, x15, 0xffff0001ffff0001, \
    li  x11, 0xff01ff01; \
    li  x12, 0xffffffff; \
    psext.dh.b x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

