# See LICENSE for license details.

#*****************************************************************************
# psrl_ws.S
#-----------------------------------------------------------------------------
#
# Test psrl.ws instruction (packed shift right logical word).
# Operates on 64-bit register: rd = rs1 >> (rs2 & 0x1f) (logical)
# 2 elements of 32-bits each, logical shift right
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
    psrl.ws x14, x13, x11; \
  )

  # Shift by 1: 0x8000000080000000 >> 1 = 0x4000000040000000 (logical)
  TEST_CASE( 3, x14, 0x4000000040000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 1; \
    psrl.ws x14, x13, x11; \
  )

  # Shift by 2: 0x8000000080000000 >> 2 = 0x2000000020000000
  TEST_CASE( 4, x14, 0x2000000020000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 2; \
    psrl.ws x14, x13, x11; \
  )

  # Shift by 4: 0x8000000080000000 >> 4 = 0x0800000008000000
  TEST_CASE( 5, x14, 0x0800000008000000, \
    li  x13, 0x8000000080000000; \
    li  x11, 4; \
    psrl.ws x14, x13, x11; \
  )

  # Shift by 8: 0x8000000080000000 >> 8 = 0x0080000000800000
  TEST_CASE( 6, x14, 0x0080000000800000, \
    li  x13, 0x8000000080000000; \
    li  x11, 8; \
    psrl.ws x14, x13, x11; \
  )

  # Shift by 16: 0x8000000080000000 >> 16 = 0x0000800000008000
  TEST_CASE( 7, x14, 0x0000800000008000, \
    li  x13, 0x8000000080000000; \
    li  x11, 16; \
    psrl.ws x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

