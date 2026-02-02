# See LICENSE for license details.

#*****************************************************************************
# wadda.S
#-----------------------------------------------------------------------------
#
# Test wadda instruction (widening signed add accumulate to register-pair).
# rd:rd+1 = rd:rd+1 + (int64_t)rs1 + (int64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: 10 + 4 + 6 = 20
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000014, \
    li  x14, 0x0000000a; \
    li  x15, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    li  x13, 0x00000006; \
    li  x16, 0x00000000; \
    wadda x14, x11, x13; \
  )

  # Accumulate with negative: 100 + (-50) + (-30) = 20
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000014, \
    li  x14, 0x00000064; \
    li  x15, 0x00000000; \
    li  x11, 0xffffffce; \
    li  x12, 0xffffffff; \
    li  x13, 0xffffffe2; \
    li  x16, 0xffffffff; \
    wadda x14, x11, x13; \
  )

  # Accumulate zero: 5 + 0 + 0 = 5
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000005, \
    li  x14, 0x00000005; \
    li  x15, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    wadda x14, x11, x13; \
  )

  # Accumulate with carry: 0xffffffff + 1 + 1 = 0x100000001
  TEST_CASE_D32( 5, x14, x15, 0x0000000100000001, \
    li  x14, 0xffffffff; \
    li  x15, 0x00000000; \
    li  x11, 0x00000001; \
    li  x12, 0x00000000; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    wadda x14, x11, x13; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 6, x10, x11, 0x0000000000000010, \
    li  x10, 0x00000008; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wadda x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 7, x12, x13, 0x0000000000000010, \
    li  x10, 0x00000008; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wadda x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

