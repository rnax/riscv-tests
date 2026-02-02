# See LICENSE for license details.

#*****************************************************************************
# pssh1sadd_dh.S
#-----------------------------------------------------------------------------
#
# Test pssh1sadd.dh instruction (packed saturating shift left 1 and add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT((rs1:rs1+1 << 1) + rs2:rs2+1)
# 4 elements of 16-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: ((2 << 1) + 3) = 7 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x00070007, \
    li  x11, 0x00020002; \
    li  x12, 0x00000000; \
    li  x13, 0x00030003; \
    li  x16, 0x00000000; \
    pssh1sadd.dh x14, x11, x13; \
  )

  # ((5 << 1) + 10) = 20 for each halfword
  TEST_CASE_D32( 3, x14, x15, 0x00140014, \
    li  x11, 0x00050005; \
    li  x12, 0x00000000; \
    li  x13, 0x000a000a; \
    li  x16, 0x00000000; \
    pssh1sadd.dh x14, x11, x13; \
  )

  # Saturation: ((0x4000 << 1) + 0x4000) saturates to 0x7FFF
  TEST_CASE_D32( 4, x14, x15, 0x7fff7fff, \
    li  x11, 0x40004000; \
    li  x12, 0x00000000; \
    li  x13, 0x40004000; \
    li  x16, 0x00000000; \
    pssh1sadd.dh x14, x11, x13; \
  )

  # Saturation: ((0xC000 << 1) + 0xC000) saturates to 0x8000
  TEST_CASE_D32( 5, x14, x15, 0x80008000, \
    li  x11, 0xc000c000; \
    li  x12, 0x00000000; \
    li  x13, 0xc000c000; \
    li  x16, 0x00000000; \
    pssh1sadd.dh x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pssh1sadd.dh x14, x11, x13; \
  )

  # ((100 << 1) + 50) = 250 for each halfword
  TEST_CASE_D32( 7, x14, x15, 0x00fa00fa, \
    li  x11, 0x00640064; \
    li  x12, 0x00000000; \
    li  x13, 0x00320032; \
    li  x16, 0x00000000; \
    pssh1sadd.dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

