# See LICENSE for license details.

#*****************************************************************************
# nsrl.S
#-----------------------------------------------------------------------------
#
# Test nsrl instruction (narrowing shift right logical).
# rd = (uint64_t)(rs1_pair) >> (rs2 & 0x3f)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x0000000000000005 >> 0 = 0x00000005
  TEST_CASE_D32( 2, x10, x11, 0x00000005, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    li  x12, 0; \
    nsrl x8, x10, x12; \
  )

  # Shift by 1: 0x0000000000000005 >> 1 = 0x00000002
  TEST_CASE_D32( 3, x10, x11, 0x00000002, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    li  x12, 1; \
    nsrl x8, x10, x12; \
  )

  # Shift by 8: 0x0000000000000100 >> 8 = 0x00000001
  TEST_CASE_D32( 4, x10, x11, 0x00000001, \
    li  x10, 0x00000100; \
    li  x10, 0x00000000; \
    li  x12, 8; \
    nsrl x8, x10, x12; \
  )

  # Unsigned: 0xffffffffffffffff >> 1 = 0x7fffffff (zero extended)
  TEST_CASE_D32( 5, x10, x11, 0x7fffffff, \
    li  x10, 0xffffffff; \
    li  x10, 0xffffffff; \
    li  x12, 1; \
    nsrl x8, x10, x12; \
  )

  # Unsigned: 0xfffffffffffffffe >> 1 = 0x7fffffff
  TEST_CASE_D32( 6, x10, x11, 0x7fffffff, \
    li  x10, 0xfffffffe; \
    li  x10, 0xffffffff; \
    li  x12, 1; \
    nsrl x8, x10, x12; \
  )

  # Large: 0x0000000100000000 >> 32 = 0x00000001
  TEST_CASE_D32( 7, x10, x11, 0x00000001, \
    li  x10, 0x00000000; \
    li  x10, 0x00000001; \
    li  x12, 32; \
    nsrl x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

