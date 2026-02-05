# See LICENSE for license details.

#*****************************************************************************
# psra_dws.S
#-----------------------------------------------------------------------------
#
# Test psra.dws instruction (packed shift right arithmetic double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) >> (rs2 & 0x1f)
# 2 elements of 32-bits each, arithmetic shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x0000000800000008 >> 0 = 0x0000000800000008
  TEST_CASE_D32( 2, x14, x15, 0x0000000800000008, \
    li  x10, 0x00000008; \
    li  x11, 0x00000000; \
    li  x13, 0; \
    psra.dws x14, x10, x12; \
  )

  # Shift by 1: 0x0000000800000008 >> 1 = 0x0000000400000004
  TEST_CASE_D32( 3, x14, x15, 0x0000000400000004, \
    li  x10, 0x00000008; \
    li  x11, 0x00000000; \
    li  x13, 1; \
    psra.dws x14, x10, x12; \
  )

  # Shift by 8: 0x0000010000000100 >> 8 = 0x0000000100000001
  TEST_CASE_D32( 4, x14, x15, 0x0000000100000001, \
    li  x10, 0x00000100; \
    li  x11, 0x00000000; \
    li  x13, 8; \
    psra.dws x14, x10, x12; \
  )

  # Negative shift: 0xf0000000f0000000 >> 1 = 0xf8000000f8000000 (sign extended)
  TEST_CASE_D32( 5, x14, x15, 0xf8000000f8000000, \
    li  x10, 0xf0000000; \
    li  x11, 0xffffffff; \
    li  x13, 1; \
    psra.dws x14, x10, x12; \
  )

  # Negative shift by 16: 0x80000000800000000 >> 16 = 0xffff8000ffff8000
  TEST_CASE_D32( 6, x14, x15, 0xffff8000ffff8000, \
    li  x10, 0x80000000; \
    li  x11, 0xffffffff; \
    li  x13, 16; \
    psra.dws x14, x10, x12; \
  )

  # Shift by 31: 0x7fffffff7fffffff >> 31 = 0x0000000000000000
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x10, 0x7fffffff; \
    li  x11, 0x00000000; \
    li  x13, 31; \
    psra.dws x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

