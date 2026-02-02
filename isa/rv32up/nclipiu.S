# See LICENSE for license details.

#*****************************************************************************
# nclipiu.S
#-----------------------------------------------------------------------------
#
# Test nclipiu instruction (narrowing unsigned clip with immediate shift).
# Clips 64-bit register-pair value shifted right by immediate to 32-bit unsigned.
# rd = P_USAT(32, P_RS1_PAIR >> shamtd)
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
    li  x11, 0x00000000; \
    nclipiu x8, x10, 0; \
  )

  # Right shift by 4: 0x00000000000000f0 >> 4 = 0x0000000f
  TEST_CASE_D32( 3, x10, x11, 0x0000000f, \
    li  x10, 0x000000f0; \
    li  x11, 0x00000000; \
    nclipiu x8, x10, 4; \
  )

  # Saturation at max unsigned: 0xffffffffffffffff >> 0 saturates to 0xffffffff
  TEST_CASE_D32( 4, x10, x11, 0xffffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    nclipiu x8, x10, 0; \
  )

  # Large positive with shift: 0x00000001ffffffff >> 1 = 0x00000000ffffffff (saturates to 0xffffffff)
  TEST_CASE_D32( 5, x10, x11, 0xffffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000001; \
    nclipiu x8, x10, 1; \
  )

  # Shift with saturation: 0x0000000100000000 >> 0 saturates to 0xffffffff
  TEST_CASE_D32( 6, x10, x11, 0xffffffff, \
    li  x10, 0x00000000; \
    li  x11, 0x00000001; \
    nclipiu x8, x10, 0; \
  )

  # Zero input
  TEST_CASE_D32( 7, x10, x11, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    nclipiu x8, x10, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

