# See LICENSE for license details.

#*****************************************************************************
# psra_dhs.S
#-----------------------------------------------------------------------------
#
# Test psra.dhs instruction (packed shift right arithmetic double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) >> (rs2 & 0xf)
# 4 elements of 16-bits each, arithmetic shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x0008000800080008 >> 0 = 0x0008000800080008
  TEST_CASE_D32( 2, x14, x15, 0x0008000800080008, \
    li  x11, 0x00080008; \
    li  x12, 0x00000000; \
    li  x13, 0; \
    psra.dhs x14, x11, x13; \
  )

  # Shift by 1: 0x0008000800080008 >> 1 = 0x0004000400040004
  TEST_CASE_D32( 3, x14, x15, 0x0004000400040004, \
    li  x11, 0x00080008; \
    li  x12, 0x00000000; \
    li  x13, 1; \
    psra.dhs x14, x11, x13; \
  )

  # Shift by 4: 0x0100010001000100 >> 4 = 0x0010001000100010
  TEST_CASE_D32( 4, x14, x15, 0x0010001000100010, \
    li  x11, 0x01000100; \
    li  x12, 0x00000000; \
    li  x13, 4; \
    psra.dhs x14, x11, x13; \
  )

  # Negative shift: 0xf000f000f000f000 >> 1 = 0xf800f800f800f800 (sign extended)
  TEST_CASE_D32( 5, x14, x15, 0xf800f800f800f800, \
    li  x11, 0xf000f000; \
    li  x12, 0xffffffff; \
    li  x13, 1; \
    psra.dhs x14, x11, x13; \
  )

  # Negative shift by 8: 0x8000800080008000 >> 8 = 0xff80ff80ff80ff80
  TEST_CASE_D32( 6, x14, x15, 0xff80ff80ff80ff80, \
    li  x11, 0x80008000; \
    li  x12, 0xffffffff; \
    li  x13, 8; \
    psra.dhs x14, x11, x13; \
  )

  # Shift by 15: 0x7fff7fff7fff7fff >> 15 = 0x0000000000000000
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x11, 0x7fff7fff; \
    li  x12, 0x00000000; \
    li  x13, 15; \
    psra.dhs x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

