# See LICENSE for license details.

#*****************************************************************************
# psub_dw.S
#-----------------------------------------------------------------------------
#
# Test psub_dw instruction (packed subtract double-word).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 - rs2:rs2+1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit subtract: 0x0000000a - 0x00000004 = 0x00000006
  TEST_CASE_D32( 2, x14, x15, 0x0000000600000006, \
    li  x11, 0x0000000a; \
    li  x12, 0x00000000; \
    li  x13, 0x00000004; \
    li  x16, 0x00000000; \
    psub_dw x14, x11, x13; \
  )

  # Negative result: 0x00000004 - 0x0000000a = 0xfffffffa
  TEST_CASE_D32( 3, x14, x15, 0xfffffffffffffffa, \
    li  x11, 0x00000004; \
    li  x12, 0x00000004; \
    li  x13, 0x0000000a; \
    li  x16, 0x0000000a; \
    psub_dw x14, x11, x13; \
  )

  # Zero cases: 0x00000000 - 0x00000000 = 0x00000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    psub_dw x14, x11, x13; \
  )

  # Large positive: 0x7fffffff - 0x00000001 = 0x7ffffffe
  TEST_CASE_D32( 5, x14, x15, 0x7ffffffe7ffffffe, \
    li  x11, 0x7fffffff; \
    li  x12, 0x7fffffff; \
    li  x13, 0x00000001; \
    li  x16, 0x00000001; \
    psub_dw x14, x11, x13; \
  )

  # Same values: 0xaaaaaaaa - 0xaaaaaaaa = 0x00000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    li  x16, 0xaaaaaaaa; \
    psub_dw x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

