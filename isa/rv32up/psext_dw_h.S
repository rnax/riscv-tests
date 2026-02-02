# See LICENSE for license details.

#*****************************************************************************
# psext_dw_h.S
#-----------------------------------------------------------------------------
#
# Test psext.dw.h instruction (packed sign-extend halfword to double-word).
# Operates on 64-bit register pairs: rd:rd+1 = sign_extend(rs1:rs1+1 halfwords to words)
# 2 elements of 16-bits extended to 32-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive halfword: 0x1234 -> 0x00001234
  TEST_CASE_D32( 2, x14, x15, 0x0000123400001234, \
    li  x11, 0x12341234; \
    li  x12, 0x00000000; \
    psext.dw.h x14, x11; \
  )

  # Negative halfword: 0x8000 -> 0xffff8000
  TEST_CASE_D32( 3, x14, x15, 0xffff8000ffff8000, \
    li  x11, 0x80008000; \
    li  x12, 0xffffffff; \
    psext.dw.h x14, x11; \
  )

  # Zero: 0x0000 -> 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    psext.dw.h x14, x11; \
  )

  # Max positive: 0x7fff -> 0x00007fff
  TEST_CASE_D32( 5, x14, x15, 0x00007fff00007fff, \
    li  x11, 0x7fff7fff; \
    li  x12, 0x00000000; \
    psext.dw.h x14, x11; \
  )

  # Min negative: 0xffff -> 0xffffffff
  TEST_CASE_D32( 6, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    psext.dw.h x14, x11; \
  )

  # Mixed: 0x0100 -> 0x00000100, 0xff00 -> 0xffffff00
  TEST_CASE_D32( 7, x14, x15, 0xffffff0000000100, \
    li  x11, 0xff000100; \
    li  x12, 0xffffffff; \
    psext.dw.h x14, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

