# See LICENSE for license details.

#*****************************************************************************
# paaddu_dh.S
#-----------------------------------------------------------------------------
#
# Test paaddu.dh instruction (packed unsigned averaging add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 + rs2:rs2+1) >> 1
# 4 elements of 16-bits each, unsigned averaging add
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic averaging add: (1000 + 2000) >> 1 = 1500 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x05dc05dc05dc05dc, \
    li  x11, 0x03e803e8; \
    li  x12, 0x00000000; \
    li  x13, 0x07d007d0; \
    li  x16, 0x00000000; \
    paaddu.dh x14, x11, x13; \
  )

  # Odd sum truncation: (65535 + 65534) >> 1 = 65534 for each halfword
  TEST_CASE_D32( 3, x14, x15, 0xfffefffefffefffe, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0xfefefefe; \
    li  x16, 0x00000000; \
    paaddu.dh x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    paaddu.dh x14, x11, x13; \
  )

  # Large values: (65535 + 65535) >> 1 = 65535 for each halfword
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0xffffffff; \
    li  x16, 0x00000000; \
    paaddu.dh x14, x11, x13; \
  )

  # Mixed values: (500 + 1000) >> 1 = 750 for each halfword
  TEST_CASE_D32( 6, x14, x15, 0x02ee02ee02ee02ee, \
    li  x11, 0x01f401f4; \
    li  x12, 0x00000000; \
    li  x13, 0x03e803e8; \
    li  x16, 0x00000000; \
    paaddu.dh x14, x11, x13; \
  )

  # Across register pair
  TEST_CASE_D32( 7, x10, x11, 0x04b004b001f401f4, \
    li  x10, 0x01f401f4; \
    li  x11, 0x00000000; \
    li  x12, 0x07d007d0; \
    li  x13, 0x00000000; \
    paaddu.dh x10, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

