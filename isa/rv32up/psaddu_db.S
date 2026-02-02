# See LICENSE for license details.

#*****************************************************************************
# psaddu_db.S
#-----------------------------------------------------------------------------
#
# Test psaddu.db instruction (packed unsigned saturating add double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 + rs2:rs2+1)
# 8 elements of 8-bits each, unsigned with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 10 + 20 = 30 for each byte
  TEST_CASE_D32( 2, x14, x15, 0x1e1e1e1e1e1e1e1e, \
    li  x11, 0x0a0a0a0a; \
    li  x12, 0x0a0a0a0a; \
    li  x13, 0x14141414; \
    li  x16, 0x14141414; \
    psaddu.db x14, x11, x13; \
  )

  # Saturation at max unsigned: 200 + 100 = 300 (saturates to 255)
  TEST_CASE_D32( 3, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xc8c8c8c8; \
    li  x12, 0xc8c8c8c8; \
    li  x13, 0x64646464; \
    li  x16, 0x64646464; \
    psaddu.db x14, x11, x13; \
  )

  # No saturation: 100 + 100 = 200
  TEST_CASE_D32( 4, x14, x15, 0xc8c8c8c8c8c8c8c8, \
    li  x11, 0x64646464; \
    li  x12, 0x64646464; \
    li  x13, 0x64646464; \
    li  x16, 0x64646464; \
    psaddu.db x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    psaddu.db x14, x11, x13; \
  )

  # Mixed values: 50 + 30 = 80
  TEST_CASE_D32( 6, x14, x15, 0x5050505050505050, \
    li  x11, 0x32323232; \
    li  x12, 0x32323232; \
    li  x13, 0x1e1e1e1e; \
    li  x16, 0x1e1e1e1e; \
    psaddu.db x14, x11, x13; \
  )

  # Large values: 255 + 1 = 256 (saturates to 255)
  TEST_CASE_D32( 7, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x01010101; \
    li  x16, 0x01010101; \
    psaddu.db x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

