# See LICENSE for license details.

#*****************************************************************************
# psub_db.S
#-----------------------------------------------------------------------------
#
# Test psub_db instruction (packed subtract double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 - rs2:rs2+1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit subtract: 0x0a0a0a0a - 0x04040404 = 0x06060606
  TEST_CASE_D32( 2, x14, x15, 0x0606060606060606, \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x0a0a0a0a; \
    li  x13, 0x04040404; \
    li  x16, 0x04040404; \
    psub_db x14, x11, x13; \
  )

  # Negative result: 0x04040404 - 0x0a0a0a0a = 0xfafafafafa
  TEST_CASE_D32( 3, x14, x15, 0xfafafafafafafafa, \
    li  x11, 0x04040404; \
    li  x12, 0x04040404; \
    li  x13, 0x0a0a0a0a; \
    li  x16, 0x0a0a0a0a; \
    psub_db x14, x11, x13; \
  )

  # Zero cases: 0x00000000 - 0x00000000 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    psub_db x14, x11, x13; \
  )

  # Large positive: 0x7f7f7f7f - 0x01010101 = 0x7e7e7e7e
  TEST_CASE_D32( 5, x14, x15, 0x7e7e7e7e7e7e7e7e, \
    li  x11, 0x7f7f7f7f; \
    li  x12, 0x7f7f7f7f; \
    li  x13, 0x01010101; \
    li  x16, 0x01010101; \
    psub_db x14, x11, x13; \
  )

  # Same values: 0xaaaaaaaa - 0xaaaaaaaa = 0x00000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    li  x16, 0xaaaaaaaa; \
    psub_db x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

