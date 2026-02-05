# See LICENSE for license details.

#*****************************************************************************
# pasubu_dw.S
#-----------------------------------------------------------------------------
#
# Test pasubu.dw instruction (packed unsigned averaging subtract double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 - rs2:rs2+1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit unsigned averaging subtract: (0x0000000a - 0x00000004) >> 1 = 0x00000003
  TEST_CASE_D32( 2, x14, x15, 0x0000000300000003, \
    li  x10, 0x0000000a; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    pasubu.dw x14, x10, x12; \
  )

  # Large unsigned values: (0xffffffff - 0x00000001) >> 1 = 0x7fffffff
  TEST_CASE_D32( 3, x14, x15, 0x7fffffff7fffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x12, 0x00000001; \
    li  x13, 0x00000001; \
    pasubu.dw x14, x10, x12; \
  )

  # Zero cases: (0x00000000 - 0x00000000) >> 1 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pasubu.dw x14, x10, x12; \
  )

  # Odd difference: (0x0000000f - 0x0000000a) >> 1 = 0x00000002
  TEST_CASE_D32( 5, x14, x15, 0x0000000200000002, \
    li  x10, 0x0000000f; \
    li  x11, 0x0000000f; \
    li  x12, 0x0000000a; \
    li  x13, 0x0000000a; \
    pasubu.dw x14, x10, x12; \
  )

  # Same values: (0xaaaaaaaa - 0xaaaaaaaa) >> 1 = 0x00000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x10, 0xaaaaaaaa; \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    pasubu.dw x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

