# See LICENSE for license details.

#*****************************************************************************
# pasub_dw.S
#-----------------------------------------------------------------------------
#
# Test pasub_dw instruction (packed averaging subtract double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1 - rs2:rs2+1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit averaging subtract: (0x0000000a - 0x00000004) >> 1 = 0x00000003
  TEST_CASE_D32( 2, x14, x15, 0x0000000300000003, \
    li  x11, 0x0000000a; \
    li  x12, 0x00000000; \
    li  x13, 0x00000004; \
    li  x16, 0x00000000; \
    pasub_dw x14, x11, x13; \
  )

  # Negative numbers: (0xfffffffc - 0x00000006) >> 1 = 0xfffffff3
  TEST_CASE_D32( 3, x14, x15, 0xfffffff3fffffff3, \
    li  x11, 0xfffffffc; \
    li  x12, 0xffffffff; \
    li  x13, 0x00000006; \
    li  x16, 0x00000000; \
    pasub_dw x14, x11, x13; \
  )

  # Zero cases: (0x00000000 - 0x00000000) >> 1 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    pasub_dw x14, x11, x13; \
  )

  # Large positive: (0x7fffffff - 0x00000001) >> 1 = 0x3fffffff
  TEST_CASE_D32( 5, x14, x15, 0x3fffffff3fffffff, \
    li  x11, 0x7fffffff; \
    li  x12, 0x7fffffff; \
    li  x13, 0x00000001; \
    li  x16, 0x00000001; \
    pasub_dw x14, x11, x13; \
  )

  # Odd difference: (0x00000007 - 0x00000004) >> 1 = 0x00000001
  TEST_CASE_D32( 6, x14, x15, 0x0000000100000001, \
    li  x11, 0x00000007; \
    li  x12, 0x00000007; \
    li  x13, 0x00000004; \
    li  x16, 0x00000004; \
    pasub_dw x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

