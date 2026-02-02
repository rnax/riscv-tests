# See LICENSE for license details.

#*****************************************************************************
# paaddu_db.S
#-----------------------------------------------------------------------------
#
# Test paaddu.db instruction (packed unsigned averaging add double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 + rs2:rs2+1) >> 1
# 8 elements of 8-bits each, unsigned averaging add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (100 + 200) >> 1 = 150 for each byte
  TEST_CASE_D32( 2, x14, x15, 0x9696969696969696, \
    li  x11, 0x64646464; \
    li  x12, 0x00000000; \
    li  x13, 0xc8c8c8c8; \
    li  x16, 0x00000000; \
    paaddu.db x14, x11, x13; \
  )

  # Odd sum truncation: (255 + 254) >> 1 = 254 for each byte
  TEST_CASE_D32( 3, x14, x15, 0xfefefefefefefefe, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0xfefefefe; \
    li  x16, 0x00000000; \
    paaddu.db x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    paaddu.db x14, x11, x13; \
  )

  # Large values: (255 + 255) >> 1 = 255 for each byte
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0xffffffff; \
    li  x16, 0x00000000; \
    paaddu.db x14, x11, x13; \
  )

  # Mixed values: (50 + 100) >> 1 = 75 for each byte
  TEST_CASE_D32( 6, x14, x15, 0x4b4b4b4b4b4b4b4b, \
    li  x11, 0x32323232; \
    li  x12, 0x00000000; \
    li  x13, 0x64646464; \
    li  x16, 0x00000000; \
    paaddu.db x14, x11, x13; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x6464646432323232, \
    li  x10, 0x28282828; \
    li  x11, 0x00000000; \
    li  x12, 0x50505050; \
    li  x13, 0x00000000; \
    paaddu.db x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

