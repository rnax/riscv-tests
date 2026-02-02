# See LICENSE for license details.

#*****************************************************************************
# pssubu_dh.S
#-----------------------------------------------------------------------------
#
# Test pssubu_dh instruction (packed unsigned saturating subtract double-halfword).
# Operates on 64-bit register pairs with unsigned saturation.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit unsigned saturating subtract: 0x000a - 0x0004 = 0x0006
  TEST_CASE_D32( 2, x14, x15, 0x0006000600060006, \
    li  x11, 0x000a000a; \
    li  x12, 0x000a000a; \
    li  x13, 0x00040004; \
    li  x16, 0x00040004; \
    pssubu_dh x14, x11, x13; \
  )

  # Underflow saturation: 0x0004 - 0x000a = 0x0000 (saturated)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x11, 0x00040004; \
    li  x12, 0x00040004; \
    li  x13, 0x000a000a; \
    li  x16, 0x000a000a; \
    pssubu_dh x14, x11, x13; \
  )

  # Zero cases: 0x0000 - 0x0000 = 0x0000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pssubu_dh x14, x11, x13; \
  )

  # Max value: 0xffff - 0x0001 = 0xfffe
  TEST_CASE_D32( 5, x14, x15, 0xfffefffefffeffffe, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x00010001; \
    li  x16, 0x00010001; \
    pssubu_dh x14, x11, x13; \
  )

  # Same values: 0xaaaa - 0xaaaa = 0x0000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    li  x16, 0xaaaaaaaa; \
    pssubu_dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

