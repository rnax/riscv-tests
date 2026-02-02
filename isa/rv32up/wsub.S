# See LICENSE for license details.

#*****************************************************************************
# wsub.S
#-----------------------------------------------------------------------------
#
# Test wsub instruction (widening signed subtract to register-pair).
# rd:rd+1 = (int64_t)rs1 - (int64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening subtract: 10 - 4 = 6
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000006, \
    li  x11, 0x0000000a; \
    li  x12, 0x00000000; \
    li  x13, 0x00000004; \
    li  x16, 0x00000000; \
    wsub x14, x11, x13; \
  )

  # Widening subtract with negative result: 4 - 10 = -6
  TEST_CASE_D32( 3, x14, x15, 0xfffffffffffffffa, \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    li  x13, 0x0000000a; \
    li  x16, 0x00000000; \
    wsub x14, x11, x13; \
  )

  # Negative subtract: -4 - (-6) = 2
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000002, \
    li  x11, 0xfffffffc; \
    li  x12, 0xffffffff; \
    li  x13, 0xfffffffa; \
    li  x16, 0xffffffff; \
    wsub x14, x11, x13; \
  )

  # Subtract from zero: 0 - 5 = -5
  TEST_CASE_D32( 5, x14, x15, 0xfffffffffffffffb, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000005; \
    li  x16, 0x00000000; \
    wsub x14, x11, x13; \
  )

  # Zero subtract: 5 - 0 = 5
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000005, \
    li  x11, 0x00000005; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    wsub x14, x11, x13; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 7, x10, x11, 0x0000000000000000, \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wsub x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 8, x12, x13, 0x0000000000000000, \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wsub x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

