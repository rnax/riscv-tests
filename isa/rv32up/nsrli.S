# See LICENSE for license details.

#*****************************************************************************
# nsrli.S
#-----------------------------------------------------------------------------
#
# Test nsrli instruction (narrowing shift right logical with immediate).
# rd = (uint64_t)(rs1_pair) >> shamtd
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
    nsrli x8, x10, 0; \
  )

  # Shift by 1: 0x0000000000000005 >> 1 = 0x00000002
  TEST_CASE_D32( 3, x10, x11, 0x00000002, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    nsrli x8, x10, 1; \
  )

  # Shift by 8: 0x0000000000000100 >> 8 = 0x00000001
  TEST_CASE_D32( 4, x10, x11, 0x00000001, \
    li  x10, 0x00000100; \
    li  x10, 0x00000000; \
    nsrli x8, x10, 8; \
  )

  # Unsigned: 0xffffffffffffffff >> 1 = 0x7fffffff (zero extended)
  TEST_CASE_D32( 5, x10, x11, 0x7fffffff, \
    li  x10, 0xffffffff; \
    li  x10, 0xffffffff; \
    nsrli x8, x10, 1; \
  )

  # Unsigned: 0xfffffffffffffffe >> 1 = 0x7fffffff
  TEST_CASE_D32( 6, x10, x11, 0x7fffffff, \
    li  x10, 0xfffffffe; \
    li  x10, 0xffffffff; \
    nsrli x8, x10, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

