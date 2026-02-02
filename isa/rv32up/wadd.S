# See LICENSE for license details.

#*****************************************************************************
# wadd.S
#-----------------------------------------------------------------------------
#
# Test wadd instruction (widening signed add to register-pair).
# rd:rd+1 = (int64_t)rs1 + (int64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening add: 4 + 6 = 10
  TEST_CASE_D32( 2, x14, x15, 0x000000000000000a, \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    li  x13, 0x00000006; \
    li  x16, 0x00000000; \
    wadd x14, x11, x13; \
  )

  # Widening add with larger values: 0x7fffffff + 0x7fffffff = 0xfffffffe
  TEST_CASE_D32( 3, x14, x15, 0x00000000fffffffe, \
    li  x11, 0x7fffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x7fffffff; \
    li  x16, 0x00000000; \
    wadd x14, x11, x13; \
  )

  # Negative widening add: -4 + -6 = -10
  TEST_CASE_D32( 4, x14, x15, 0xfffffffffffffff6, \
    li  x11, 0xfffffffc; \
    li  x12, 0xffffffff; \
    li  x13, 0xfffffffa; \
    li  x16, 0xffffffff; \
    wadd x14, x11, x13; \
  )

  # Mixed sign: -1 + 1 = 0
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    wadd x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    wadd x14, x11, x13; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 7, x10, x11, 0x0000000000000008, \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wadd x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 8, x12, x13, 0x0000000000000008, \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wadd x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

