# See LICENSE for license details.

#*****************************************************************************
# wmulu.S
#-----------------------------------------------------------------------------
#
# Test wmulu instruction (widening unsigned multiply).
# rd:rd+1 = (unsigned)rs1 * (unsigned)rs2 (64-bit result from 32x32 unsigned multiply)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # wmulu rd, rs1, rs2: rd:rd+1 = (unsigned)rs1 * (unsigned)rs2
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000015, \
    li  x10, 0x00000003; \
    li  x12, 0x00000007; \
    wmulu x14, x10, x12; \
  )

  # Larger: 100 * 200 = 20000 (0x4E20)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000004e20, \
    li  x10, 0x00000064; \
    li  x12, 0x000000c8; \
    wmulu x14, x10, x12; \
  )

  # Large unsigned: 0x10000 * 0x10000 = 0x100000000
  TEST_CASE_D32( 4, x14, x15, 0x0000000100000000, \
    li  x10, 0x00010000; \
    li  x12, 0x00010000; \
    wmulu x14, x10, x12; \
  )

  # Max unsigned * 1: 0xFFFFFFFF * 1 = 0xFFFFFFFF
  TEST_CASE_D32( 5, x14, x15, 0x00000000ffffffff, \
    li  x10, 0xffffffff; \
    li  x12, 0x00000001; \
    wmulu x14, x10, x12; \
  )

  # Zero cases
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x12, 0x00000000; \
    wmulu x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

