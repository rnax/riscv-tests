# See LICENSE for license details.

#*****************************************************************************
# nsrari.S
#-----------------------------------------------------------------------------
#
# Test nsrari instruction (narrowing shift right arithmetic with rounding and immediate).
# rd = (int64_t)(rs1_pair) >> shamtd + round_bit
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
    nsrari x8, x10, 0; \
  )

  # Shift by 1 with rounding: 0x0000000000000005 >> 1 + round = 0x00000003
  TEST_CASE_D32( 3, x10, x11, 0x00000003, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    nsrari x8, x10, 1; \
  )

  # Shift by 2 with rounding: 0x0000000000000005 >> 2 + round = 0x00000001
  TEST_CASE_D32( 4, x10, x11, 0x00000001, \
    li  x10, 0x00000005; \
    li  x10, 0x00000000; \
    nsrari x8, x10, 2; \
  )

  # Negative with rounding: 0xffffffffffffffff >> 1 + round = 0xffffffff
  TEST_CASE_D32( 5, x10, x11, 0xffffffff, \
    li  x10, 0xffffffff; \
    li  x10, 0xffffffff; \
    nsrari x8, x10, 1; \
  )

  # Negative with rounding: 0xfffffffffffffffe >> 1 + round = 0xffffffff
  TEST_CASE_D32( 6, x10, x11, 0xffffffff, \
    li  x10, 0xfffffffe; \
    li  x10, 0xffffffff; \
    nsrari x8, x10, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

