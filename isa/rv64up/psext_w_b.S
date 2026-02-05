# See LICENSE for license details.

#*****************************************************************************
# psext_w_b.S
#-----------------------------------------------------------------------------
#
# Test psext.w.b instruction (packed sign-extend byte to word).
# Operates on 64-bit register: rd = sign_extend(rs1 bytes to words)
# 4 elements of 8-bits extended to 32-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive byte: 0x42 -> 0x00000042
  TEST_CASE( 2, x14, 0x0000004200000042, \
    li  x11, 0x4242424242424242; \
    psext.w.b x14, x11; \
  )

  # Negative byte: 0x80 -> 0xffffff80
  TEST_CASE( 3, x14, 0xffffff80ffffff80, \
    li  x11, 0x8080808080808080; \
    psext.w.b x14, x11; \
  )

  # Zero: 0x00 -> 0x00000000
  TEST_CASE( 4, x14, 0x0000000000000000, \
    li  x11, 0x0000000000000000; \
    psext.w.b x14, x11; \
  )

  # Max positive: 0x7f -> 0x0000007f
  TEST_CASE( 5, x14, 0x000000ff0000007f, \
    li  x11, 0xff7fff7fff7fff7f; \
    psext.w.b x14, x11; \
  )

  # Min negative: 0xff -> 0xffffffff
  TEST_CASE( 6, x14, 0xffffffffffffffff, \
    li  x11, 0xffffffffffffffff; \
    psext.w.b x14, x11; \
  )

  # Mixed positive and negative: 0x01 -> 0x00000001, 0xff -> 0xffffffff
  TEST_CASE( 7, x14, 0xffffffff00000001, \
    li  x11, 0xff01ff01ff01ff01; \
    psext.w.b x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

