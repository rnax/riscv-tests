# See LICENSE for license details.

#*****************************************************************************
# psrai_w.S
#-----------------------------------------------------------------------------
#
# Test psrai.w instruction (packed shift right arithmetic immediate word).
# Operates on 64-bit register: rd = rs1 >> imm (imm in 0-31, arithmetic)
# 2 elements of 32-bits each, arithmetic shift right by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x8000000080000000 >> 0 = 0x8000000080000000
  TEST_CASE( 2, x14, 0x8000000080000000, \
    li  x13, 0x8000000080000000; \
    psrai.w x14, x13, 0; \
  )

  # Shift by 1: 0x8000000080000000 >> 1 = 0xc000000c0000000 (sign extended)
  TEST_CASE( 3, x14, 0xc000000c0000000, \
    li  x13, 0x8000000080000000; \
    psrai.w x14, x13, 1; \
  )

  # Shift by 2: 0x8000000080000000 >> 2 = 0xe000000e0000000
  TEST_CASE( 4, x14, 0xe000000e0000000, \
    li  x13, 0x8000000080000000; \
    psrai.w x14, x13, 2; \
  )

  # Shift by 4: 0x8000000080000000 >> 4 = 0xf800000f8000000
  TEST_CASE( 5, x14, 0xf800000f8000000, \
    li  x13, 0x8000000080000000; \
    psrai.w x14, x13, 4; \
  )

  # Positive value: 0x7fffffff7fffffff >> 1 = 0x3fffffff3fffffff
  TEST_CASE( 6, x14, 0x3fffffff3fffffff, \
    li  x13, 0x7fffffff7fffffff; \
    psrai.w x14, x13, 1; \
  )

  # Shift by 16: 0x8000000080000000 >> 16 = 0xffff8000ffff8000
  TEST_CASE( 7, x14, 0xffff8000ffff8000, \
    li  x13, 0x8000000080000000; \
    psrai.w x14, x13, 16; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

