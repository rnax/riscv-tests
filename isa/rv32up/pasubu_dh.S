# See LICENSE for license details.

#*****************************************************************************
# pasubu_dh.S
#-----------------------------------------------------------------------------
#
# Test pasubu_dh instruction (packed unsigned averaging subtract double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 - rs2:rs2+1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit unsigned averaging subtract: (0x000a000a - 0x00040004) >> 1 = 0x00030003
  TEST_CASE_D32( 2, x14, x15, 0x0003000300030003, \
    li  x11, 0x000a000a; \
    li  x12, 0x000a000a; \
    li  x13, 0x00040004; \
    li  x16, 0x00040004; \
    pasubu_dh x14, x11, x13; \
  )

  # Large unsigned values: (0xffff - 0x0001) >> 1 = 0x7fff
  TEST_CASE_D32( 3, x14, x15, 0x7fff7fff7fff7fff, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x00010001; \
    li  x16, 0x00010001; \
    pasubu_dh x14, x11, x13; \
  )

  # Zero cases: (0x0000 - 0x0000) >> 1 = 0x0000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pasubu_dh x14, x11, x13; \
  )

  # Odd difference: (0x000f - 0x000a) >> 1 = 0x0002
  TEST_CASE_D32( 5, x14, x15, 0x0002000200020002, \
    li  x11, 0x000f000f; \
    li  x12, 0x000f000f; \
    li  x13, 0x000a000a; \
    li  x16, 0x000a000a; \
    pasubu_dh x14, x11, x13; \
  )

  # Same values: (0xaaaa - 0xaaaa) >> 1 = 0x0000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    li  x16, 0xaaaaaaaa; \
    pasubu_dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

