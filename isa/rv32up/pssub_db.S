# See LICENSE for license details.

#*****************************************************************************
# pssub_db.S
#-----------------------------------------------------------------------------
#
# Test pssub.db instruction (packed saturating subtract double-byte).
# Operates on 64-bit register pairs with signed saturation.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit saturating subtract: 0x0a - 0x04 = 0x06
  TEST_CASE_D32( 2, x14, x15, 0x0606060606060606, \
    li  x10, 0x0a0a0a0a; \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x04040404; \
    li  x13, 0x04040404; \
    pssub.db x14, x10, x12; \
  )

  # Saturation case: 0x80 - 0x01 = 0x7f (saturated from 0x7f)
  TEST_CASE_D32( 3, x14, x15, 0x7f7f7f7f7f7f7f7f, \
    li  x10, 0x80808080; \
    li  x11, 0x80808080; \
    li  x12, 0x01010101; \
    li  x13, 0x01010101; \
    pssub.db x14, x10, x12; \
  )

  # Zero cases: 0x00 - 0x00 = 0x00
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pssub.db x14, x10, x12; \
  )

  # Negative saturation: 0x7f - 0x80 = 0x80 (saturated from -129)
  TEST_CASE_D32( 5, x14, x15, 0x8080808080808080, \
    li  x10, 0x7f7f7f7f; \
    li  x11, 0x7f7f7f7f; \
    li  x12, 0x80808080; \
    li  x13, 0x80808080; \
    pssub.db x14, x10, x12; \
  )

  # Normal negative: 0x04 - 0x0a = 0xfa
  TEST_CASE_D32( 6, x14, x15, 0xfafafafafafafafa, \
    li  x10, 0x04040404; \
    li  x11, 0x04040404; \
    li  x12, 0x0a0a0a0a; \
    li  x13, 0x0a0a0a0a; \
    pssub.db x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

