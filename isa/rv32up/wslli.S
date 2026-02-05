# See LICENSE for license details.

#*****************************************************************************
# wslli.S
#-----------------------------------------------------------------------------
#
# Test wslli instruction (widening shift left logical immediate).
# rd_pair = (uint64_t)(uint32_t)rs1 << shamtd
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wslli rd, rs1, shamtd: rd:rd+1 = (uint64_t)(uint32_t)rs1 << shamtd
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000001, \
    li  x10, 0x00000001; \
    wslli x14, x10, 0; \
  )

  # 0x00000001 << 1 = 0x0000000000000002
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000002, \
    li  x10, 0x00000001; \
    wslli x14, x10, 1; \
  )

  # 0x00000001 << 31 = 0x0000000080000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000080000000, \
    li  x10, 0x00000001; \
    wslli x14, x10, 31; \
  )

  # 0xFFFFFFFF << 0 = 0x00000000FFFFFFFF
  TEST_CASE_D32( 5, x14, x15, 0x00000000ffffffff, \
    li  x10, 0xffffffff; \
    wslli x14, x10, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

