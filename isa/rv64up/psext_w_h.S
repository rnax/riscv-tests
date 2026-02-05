# See LICENSE for license details.

#*****************************************************************************
# psext_w_h.S
#-----------------------------------------------------------------------------
#
# Test psext.w.h instruction (packed sign-extend halfword to word).
# Operates on 64-bit register: rd = sign_extend(rs1 halfwords to words)
# 2 elements of 16-bits extended to 32-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive halfword: 0x4242 -> 0x00004242
  TEST_CASE( 2, x14, 0x0000424200004242, \
    li  x11, 0x4242424242424242; \
    psext.w.h x14, x11; \
  )

  # Negative halfword: 0x8000 -> 0xffff8000
  TEST_CASE( 3, x14, 0xffff8000ffff8000, \
    li  x11, 0x8000800080008000; \
    psext.w.h x14, x11; \
  )

  # Zero: 0x0000 -> 0x00000000
  TEST_CASE( 4, x14, 0x0000000000000000, \
    li  x11, 0x0000000000000000; \
    psext.w.h x14, x11; \
  )

  # Max positive: 0x7fff -> 0x00007fff
  TEST_CASE( 5, x14, 0x00007fff00007fff, \
    li  x11, 0x7fff7fff7fff7fff; \
    psext.w.h x14, x11; \
  )

  # Min negative: 0xffff -> 0xffffffff
  TEST_CASE( 6, x14, 0xffffffffffffffff, \
    li  x11, 0xffffffffffffffff; \
    psext.w.h x14, x11; \
  )

  # Mixed positive and negative: 0x0001 -> 0x00000001, 0xffff -> 0xffffffff
  TEST_CASE( 7, x14, 0xffffffff00000001, \
    li  x11, 0xffff0001ffff0001; \
    psext.w.h x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

