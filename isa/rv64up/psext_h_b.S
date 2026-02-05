# See LICENSE for license details.

#*****************************************************************************
# psext_h_b.S
#-----------------------------------------------------------------------------
#
# Test psext.h.b instruction (packed sign-extend byte to halfword).
# Operates on 32-bit register: rd = sign_extend(rs1 bytes to halfwords)
# 2 elements of 8-bits extended to 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive byte: 0x42 -> 0x0042
  TEST_CASE( 2, x14, 0x00420042, \
    li  x11, 0x42424242; \
    psext.h.b x14, x11; \
  )

  # Negative byte: 0x80 -> 0xff80
  TEST_CASE( 3, x14, 0xff80ff80, \
    li  x11, 0x80808080; \
    psext.h.b x14, x11; \
  )

  # Zero: 0x00 -> 0x0000
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x00000000; \
    psext.h.b x14, x11; \
  )

  # Max positive: 0x7f -> 0x007f
  TEST_CASE( 5, x14, 0x007f007f, \
    li  x11, 0x7f7f7f7f; \
    psext.h.b x14, x11; \
  )

  # Min negative: 0xff -> 0xffff
  TEST_CASE( 6, x14, 0xffffffff, \
    li  x11, 0xffffffff; \
    psext.h.b x14, x11; \
  )

  # Mixed: 0x01 -> 0x0001, 0xff -> 0xffff
  TEST_CASE( 7, x14, 0xffff0001, \
    li  x11, 0xff01ff01; \
    psext.h.b x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

