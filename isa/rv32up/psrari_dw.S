# See LICENSE for license details.

#*****************************************************************************
# psrari_dw.S
#-----------------------------------------------------------------------------
#
# Test psrari.dw instruction (packed shift right arithmetic with rounding immediate double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) >> imm with rounding (imm in 0-31)
# 2 elements of 32-bits each, arithmetic shift right with rounding by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0000000800000008 >> 0 = 0x0000000800000008
  TEST_CASE_D32( 2, x14, x15, 0x0000000800000008, \
    li  x11, 0x00000008; \
    li  x12, 0x00000000; \
    psrari.dw x14, x11, 0; \
  )

  # Shift by 1 with rounding: 0x0000000900000009 >> 1 = 0x0000000500000005 (rounded)
  TEST_CASE_D32( 3, x14, x15, 0x0000000500000005, \
    li  x11, 0x00000009; \
    li  x12, 0x00000000; \
    psrari.dw x14, x11, 1; \
  )

  # Shift by 8 with rounding: 0x0000010000000100 >> 8 = 0x0000000100000001
  TEST_CASE_D32( 4, x14, x15, 0x0000000100000001, \
    li  x11, 0x00000100; \
    li  x12, 0x00000000; \
    psrari.dw x14, x11, 8; \
  )

  # Negative shift with rounding: 0xf0000000f0000000 >> 1 = 0xf8000000f8000000 (sign extended, rounded)
  TEST_CASE_D32( 5, x14, x15, 0xf8000000f8000000, \
    li  x11, 0xf0000000; \
    li  x12, 0xffffffff; \
    psrari.dw x14, x11, 1; \
  )

  # Negative shift by 16 with rounding: 0x80000000800000000 >> 16 = 0xffff8000ffff8000
  TEST_CASE_D32( 6, x14, x15, 0xffff8000ffff8000, \
    li  x11, 0x80000000; \
    li  x12, 0xffffffff; \
    psrari.dw x14, x11, 16; \
  )

  # Shift by 31: 0x7fffffff7fffffff >> 31 = 0x0000000000000000
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x11, 0x7fffffff; \
    li  x12, 0x00000000; \
    psrari.dw x14, x11, 31; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

