# See LICENSE for license details.

#*****************************************************************************
# wsla.S
#-----------------------------------------------------------------------------
#
# Test wsla instruction (widening shift left arithmetic to register-pair).
# rd_pair = (int64_t)(int32_t)rs1 << (rs2 & 63)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wsla rd, rs1, rs2: rd:rd+1 = (int64_t)(int32_t)rs1 << (rs2 & 63)
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000001, \
    li  x10, 0x00000001; \
    li  x12, 0x00000000; \
    wsla x14, x10, x12; \
  )

  # 0x00000001 << 1 = 0x0000000000000002
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000002, \
    li  x10, 0x00000001; \
    li  x12, 0x00000001; \
    wsla x14, x10, x12; \
  )

  # 0x00000001 << 31 = 0x0000000080000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000080000000, \
    li  x10, 0x00000001; \
    li  x12, 0x0000001f; \
    wsla x14, x10, x12; \
  )

  # Negative: 0xFFFFFFFF << 0 = 0xFFFFFFFFFFFFFFFF (sign-extended)
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x10, 0xffffffff; \
    li  x12, 0x00000000; \
    wsla x14, x10, x12; \
  )

  # 0xFFFFFFFF << 1 = 0xFFFFFFFFFFFFFFFE
  TEST_CASE_D32( 6, x14, x15, 0xfffffffffffffffe, \
    li  x10, 0xffffffff; \
    li  x12, 0x00000001; \
    wsla x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

