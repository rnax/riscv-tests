# See LICENSE for license details.

#*****************************************************************************
# wsuba.S
#-----------------------------------------------------------------------------
#
# Test wsuba instruction (widening signed subtract accumulate to register-pair).
# rd:rd+1 = rd:rd+1 + (int64_t)rs1 - (int64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate subtract: 20 + 10 - 4 = 26
  TEST_CASE_D32( 2, x14, x15, 0x000000000000001a, \
    li  x14, 0x00000014; \
    li  x15, 0x00000000; \
    li  x10, 0x0000000a; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wsuba x14, x10, x12; \
  )

  # Accumulate subtract with negative: 100 + (-50) - (-30) = 80
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000050, \
    li  x14, 0x00000064; \
    li  x15, 0x00000000; \
    li  x10, 0xffffffce; \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffe2; \
    li  x13, 0xffffffff; \
    wsuba x14, x10, x12; \
  )

  # Accumulate subtract zero: 5 + 0 - 0 = 5
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000005, \
    li  x14, 0x00000005; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    wsuba x14, x10, x12; \
  )

  # Accumulate subtract with borrow: 10 + 5 - 20 = -5
  TEST_CASE_D32( 5, x14, x15, 0xfffffffffffffffb, \
    li  x14, 0x0000000a; \
    li  x15, 0x00000000; \
    li  x10, 0x00000005; \
    li  x11, 0x00000000; \
    li  x12, 0x00000014; \
    li  x13, 0x00000000; \
    wsuba x14, x10, x12; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 6, x10, x11, 0x0000000000000008, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    wsuba x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 7, x12, x13, 0x0000000000000008, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    wsuba x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

