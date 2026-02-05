# See LICENSE for license details.

#*****************************************************************************
# pssubu_db.S
#-----------------------------------------------------------------------------
#
# Test pssubu.db instruction (packed unsigned saturating subtract double-byte).
# Operates on 64-bit register pairs with unsigned saturation.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit unsigned saturating subtract: 0x0a - 0x04 = 0x06
  TEST_CASE_D32( 2, x14, x15, 0x0606060606060606, \
    li  x10, 0x0a0a0a0a; \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x04040404; \
    li  x13, 0x04040404; \
    pssubu.db x14, x10, x12; \
  )

  # Underflow saturation: 0x04 - 0x0a = 0x00 (saturated from negative)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x04040404; \
    li  x11, 0x04040404; \
    li  x12, 0x0a0a0a0a; \
    li  x13, 0x0a0a0a0a; \
    pssubu.db x14, x10, x12; \
  )

  # Zero cases: 0x00 - 0x00 = 0x00
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pssubu.db x14, x10, x12; \
  )

  # Max value: 0xff - 0x01 = 0xfe
  TEST_CASE_D32( 5, x14, x15, 0xfefefefefefefefe, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x12, 0x01010101; \
    li  x13, 0x01010101; \
    pssubu.db x14, x10, x12; \
  )

  # Same values: 0xaa - 0xaa = 0x00
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x10, 0xaaaaaaaa; \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    pssubu.db x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

