# See LICENSE for license details.

#*****************************************************************************
# wsll.S
#-----------------------------------------------------------------------------
#
# Test wsll instruction (widening shift left logical to register-pair).
# rd_pair = (uint64_t)(uint32_t)rs1 << (rs2 & 63)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wsll rd, rs1, rs2: rd:rd+1 = (uint64_t)(uint32_t)rs1 << (rs2 & 63)
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000001, \
    li  x10, 0x00000001; \
    li  x12, 0x00000000; \
    wsll x14, x10, x12; \
  )

  # 0x00000001 << 1 = 0x0000000000000002
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000002, \
    li  x10, 0x00000001; \
    li  x12, 0x00000001; \
    wsll x14, x10, x12; \
  )

  # 0x00000001 << 31 = 0x0000000080000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000080000000, \
    li  x10, 0x00000001; \
    li  x12, 0x0000001f; \
    wsll x14, x10, x12; \
  )

  # 0x00000001 << 32 = 0x0000000100000000
  TEST_CASE_D32( 5, x14, x15, 0x0000000100000000, \
    li  x10, 0x00000001; \
    li  x12, 0x00000020; \
    wsll x14, x10, x12; \
  )

  # 0xFFFFFFFF << 0 = 0x00000000FFFFFFFF
  TEST_CASE_D32( 6, x14, x15, 0x00000000ffffffff, \
    li  x10, 0xffffffff; \
    li  x12, 0x00000000; \
    wsll x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

