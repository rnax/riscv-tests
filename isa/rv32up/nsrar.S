# See LICENSE for license details.

#*****************************************************************************
# nsrar.S
#-----------------------------------------------------------------------------
#
# Test nsrar instruction (narrowing shift right arithmetic with rounding).
# rd = (int64_t)(rs1_pair) >> (rs2 & 0x3f) + round_bit
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
    nsrar x8, x10, x12; \
  )

  # Shift by 1 with rounding: 0x0000000000000005 >> 1 + round = 0x00000003
  TEST_CASE_D32( 3, x10, x11, 0x00000003, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    li  x12, 1; \
    nsrar x8, x10, x12; \
  )

  # Shift by 2 with rounding: 0x0000000000000005 >> 2 + round = 0x00000001
  TEST_CASE_D32( 4, x10, x11, 0x00000001, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    li  x12, 2; \
    nsrar x8, x10, x12; \
  )

  # Negative with rounding: 0xffffffffffffffff >> 1 + round = 0xffffffff
  TEST_CASE_D32( 5, x10, x11, 0xffffffff, \
    li  x10, 0xffffffff; \
    li  x10, 0xffffffff; \
    li  x12, 1; \
    nsrar x8, x10, x12; \
  )

  # Negative with rounding: 0xfffffffffffffffe >> 1 + round = 0xffffffff
  TEST_CASE_D32( 6, x10, x11, 0xffffffff, \
    li  x10, 0xfffffffe; \
    li  x10, 0xffffffff; \
    li  x12, 1; \
    nsrar x8, x10, x12; \
  )

  # Large positive with rounding: 0x0000000100000000 >> 32 + round = 0x00000001
  TEST_CASE_D32( 7, x10, x11, 0x00000001, \
    li  x10, 0x00000000; \
    li  x10, 0x00000001; \
    li  x12, 32; \
    nsrar x8, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

