# See LICENSE for license details.

#*****************************************************************************
# psslai_dh.S
#-----------------------------------------------------------------------------
#
# Test psslai.dh instruction (packed saturating shift left arithmetic immediate double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 << imm)
# 4 elements of 16-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic left shift: 0x0001 << 1 = 0x0002 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x0002000200020002, \
    li  x11, 0x00010001; \
    li  x12, 0x00000000; \
    psslai.dh x14, x11, 1; \
  )

  # Left shift: 0x0005 << 2 = 0x0014 for each halfword
  TEST_CASE_D32( 3, x14, x15, 0x0014001400140014, \
    li  x11, 0x00050005; \
    li  x12, 0x00000000; \
    psslai.dh x14, x11, 2; \
  )

  # Saturation on left shift: 0x4000 << 1 saturates to 0x7FFF
  TEST_CASE_D32( 4, x14, x15, 0x7fff7fff7fff7fff, \
    li  x11, 0x40004000; \
    li  x12, 0x00000000; \
    psslai.dh x14, x11, 1; \
  )

  # Saturation on left shift: 0xC000 << 1 saturates to 0x8000
  TEST_CASE_D32( 5, x14, x15, 0x8000800080008000, \
    li  x11, 0xc000c000; \
    li  x12, 0x00000000; \
    psslai.dh x14, x11, 1; \
  )

  # Zero input
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    psslai.dh x14, x11, 1; \
  )

  # Zero shift amount
  TEST_CASE_D32( 7, x14, x15, 0x00050005, \
    li  x11, 0x00050005; \
    li  x12, 0x00000000; \
    psslai.dh x14, x11, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

