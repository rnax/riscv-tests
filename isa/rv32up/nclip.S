# See LICENSE for license details.

#*****************************************************************************
# nclip.S
#-----------------------------------------------------------------------------
#
# Test nclip instruction (narrowing signed clip).
# Clips 64-bit register-pair value shifted right by rs2 to 32-bit signed.
# rd = SAT(P_RS1_PAIR >> (rs2 & 0x3f))
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 0x0000000000000010 >> 0 = 0x00000010
  TEST_CASE_D32( 2, x10, x11, 0x00000010, \
    li  x10, 0x00000010; \
    li  x10, 0x00000000; \
    li  x12, 0; \
    nclip x8, x10, x12; \
  )

  # Right shift by 4: 0x00000000000000f0 >> 4 = 0x0000000f
  TEST_CASE_D32( 3, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    li  x10, 0x00000000; \
    li  x12, 4; \
    nclip x8, x10, x12; \
  )

  # Saturation at max positive: 0x7fffffffffffffff >> 0 saturates to 0x7fffffff
  TEST_CASE_D32( 4, x10, x11, 0x7fffffff, \
    li  x10, 0xffffffff; \
    li  x10, 0x7fffffff; \
    li  x12, 0; \
    nclip x8, x10, x12; \
  )

  # Saturation at min negative: 0x8000000000000000 >> 0 saturates to 0x80000000
  TEST_CASE_D32( 5, x10, x11, 0x80000000, \
    li  x10, 0x00000000; \
    li  x10, 0x80000000; \
    li  x12, 0; \
    nclip x8, x10, x12; \
  )

  # Negative value with shift: 0xffffffffffffffff >> 1 = 0xffffffff (saturates to 0x80000000)
  TEST_CASE_D32( 6, x10, x11, 0x80000000, \
    li  x10, 0xffffffff; \
    li  x10, 0xffffffff; \
    li  x12, 1; \
    nclip x8, x10, x12; \
  )

  # Zero input
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x10, 0x00000000; \
    li  x12, 0; \
    nclip x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

