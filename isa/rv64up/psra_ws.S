# See LICENSE for license details.

#*****************************************************************************
# psra_ws.S
#-----------------------------------------------------------------------------
#
# Test psra.ws instruction (packed shift right arithmetic word).
# Operates on 64-bit register: rd = rs1 >> (rs2 & 0x1f) (arithmetic)
# 2 elements of 32-bits each, arithmetic shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x8000000080000000 >> 0 = 0x8000000080000000
  TEST_CASE( 2, x14, 0x8000000080000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 0; \
    psra.ws x14, x13, x11; \
  )

  # Shift by 1: 0x8000000080000000 >> 1 = 0xc000000c0000000 (sign extended)
  TEST_CASE( 3, x14, 0xc000000c0000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 1; \
    psra.ws x14, x13, x11; \
  )

  # Shift by 2: 0x8000000080000000 >> 2 = 0xe000000e0000000
  TEST_CASE( 4, x14, 0xe000000e0000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 2; \
    psra.ws x14, x13, x11; \
  )

  # Shift by 4: 0x8000000080000000 >> 4 = 0xf800000f8000000
  TEST_CASE( 5, x14, 0xf800000f8000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 4; \
    psra.ws x14, x13, x11; \
  )

  # Positive value: 0x7fffffff7fffffff >> 1 = 0x3fffffff3fffffff
  TEST_CASE( 6, x14, 0x3fffffff3fffffff, \
    li  x13, 0x7fffffff7fffffff; \
    li  x11, 1; \
    psra.ws x14, x13, x11; \
  )

  # Shift by 16: 0x8000000080000000 >> 16 = 0xffff8000ffff8000
  TEST_CASE( 7, x14, 0xffff8000ffff8000, \
    li  x13, 0x8000000080000000; \
    li  x11, 16; \
    psra.ws x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

