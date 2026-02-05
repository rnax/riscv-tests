# See LICENSE for license details.

#*****************************************************************************
# pasub_dh.S
#-----------------------------------------------------------------------------
#
# Test pasub.dh instruction (packed averaging subtract double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 - rs2:rs2+1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit averaging subtract: (0x000a000a - 0x00040004) >> 1 = 0x00030003
  TEST_CASE_D32( 2, x14, x15, 0x0003000300030003, \
    li  x10, 0x000a000a; \
    li  x11, 0x000a000a; \
    li  x12, 0x00040004; \
    li  x13, 0x00040004; \
    pasub.dh x14, x10, x12; \
  )

  # Negative numbers: (0xfffc - 0x0006) >> 1 = 0xfff3
  TEST_CASE_D32( 3, x14, x15, 0xfff3fff3fff3fff3, \
    li  x10, 0xfffcfffc; \
    li  x11, 0xffffffff; \
    li  x12, 0x00060006; \
    li  x13, 0x00000000; \
    pasub.dh x14, x10, x12; \
  )

  # Zero cases: (0x0000 - 0x0000) >> 1 = 0x0000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pasub.dh x14, x10, x12; \
  )

  # Large positive: (0x7fff - 0x0001) >> 1 = 0x3fff
  TEST_CASE_D32( 5, x14, x15, 0x3fff3fff3fff3fff, \
    li  x10, 0x7fff7fff; \
    li  x11, 0x7fff7fff; \
    li  x12, 0x00010001; \
    li  x13, 0x00010001; \
    pasub.dh x14, x10, x12; \
  )

  # Odd difference: (0x0007 - 0x0004) >> 1 = 0x0001
  TEST_CASE_D32( 6, x14, x15, 0x0001000100010001, \
    li  x10, 0x00070007; \
    li  x11, 0x00070007; \
    li  x12, 0x00040004; \
    li  x13, 0x00040004; \
    pasub.dh x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

