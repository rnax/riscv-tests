# See LICENSE for license details.

#*****************************************************************************
# psrli_dw.S
#-----------------------------------------------------------------------------
#
# Test psrli.dw instruction (packed shift right logical immediate double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) >> imm (imm in 0-31)
# 2 elements of 32-bits each, logical shift right by immediate
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
    psrli.dw x14, x11, 0; \
  )

  # Shift by 1: 0x0000000800000008 >> 1 = 0x0000000400000004
  TEST_CASE_D32( 3, x14, x15, 0x0000000400000004, \
    li  x11, 0x00000008; \
    li  x12, 0x00000000; \
    psrli.dw x14, x11, 1; \
  )

  # Shift by 8: 0x0000010000000100 >> 8 = 0x0000000100000001
  TEST_CASE_D32( 4, x14, x15, 0x0000000100000001, \
    li  x11, 0x00000100; \
    li  x12, 0x00000000; \
    psrli.dw x14, x11, 8; \
  )

  # Logical shift (no sign extension): 0xf0000000f0000000 >> 1 = 0x78000000780000000
  TEST_CASE_D32( 5, x14, x15, 0x7800000078000000, \
    li  x11, 0xf0000000; \
    li  x12, 0xffffffff; \
    psrli.dw x14, x11, 1; \
  )

  # Logical shift by 16: 0x80000000800000000 >> 16 = 0x0000800000008000
  TEST_CASE_D32( 6, x14, x15, 0x0000800000008000, \
    li  x11, 0x80000000; \
    li  x12, 0xffffffff; \
    psrli.dw x14, x11, 16; \
  )

  # Shift by 31: 0xffffffffffffffff >> 31 = 0x0000000100000001
  TEST_CASE_D32( 7, x14, x15, 0x0000000100000001, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    psrli.dw x14, x11, 31; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

