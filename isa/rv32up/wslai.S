# See LICENSE for license details.

#*****************************************************************************
# wslai.S
#-----------------------------------------------------------------------------
#
# Test wslai instruction (widening shift left arithmetic immediate).
# rd_pair = (int64_t)(int32_t)rs1 << shamtd
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wslai rd, rs1, shamtd: rd:rd+1 = (int64_t)(int32_t)rs1 << shamtd
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000001, \
    li  x10, 0x00000001; \
    wslai x14, x10, 0; \
  )

  # 0x00000001 << 1 = 0x0000000000000002
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000002, \
    li  x10, 0x00000001; \
    wslai x14, x10, 1; \
  )

  # 0x00000001 << 31 = 0x0000000080000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000080000000, \
    li  x10, 0x00000001; \
    wslai x14, x10, 31; \
  )

  # Negative: 0xFFFFFFFF << 0 = 0xFFFFFFFFFFFFFFFF (sign-extended)
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x10, 0xffffffff; \
    wslai x14, x10, 0; \
  )

  # 0xFFFFFFFF << 1 = 0xFFFFFFFFFFFFFFFE
  TEST_CASE_D32( 6, x14, x15, 0xfffffffffffffffe, \
    li  x10, 0xffffffff; \
    wslai x14, x10, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

