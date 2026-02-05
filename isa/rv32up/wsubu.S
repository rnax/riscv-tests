# See LICENSE for license details.

#*****************************************************************************
# wsubu.S
#-----------------------------------------------------------------------------
#
# Test wsubu instruction (widening unsigned subtract to register-pair).
# rd:rd+1 = (uint64_t)rs1 - (uint64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic widening unsigned subtract: 10 - 4 = 6
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000006, \
    li  x10, 0x0000000a; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wsubu x14, x10, x12; \
  )

  # Unsigned subtract with borrow: 4 - 10 = -6 (as unsigned: 0xfffffffffffffffa)
  TEST_CASE_D32( 3, x14, x15, 0xfffffffffffffffa, \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x0000000a; \
    li  x13, 0x00000000; \
    wsubu x14, x10, x12; \
  )

  # Large unsigned subtract: 0xffffffff - 0x00000001 = 0xfffffffe
  TEST_CASE_D32( 4, x14, x15, 0x00000000fffffffe, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    wsubu x14, x10, x12; \
  )

  # Unsigned subtract from zero: 0 - 5 = -5 (as unsigned: 0xfffffffffffffffb)
  TEST_CASE_D32( 5, x14, x15, 0xfffffffffffffffb, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000005; \
    li  x13, 0x00000000; \
    wsubu x14, x10, x12; \
  )

  # Zero unsigned subtract: 5 - 0 = 5
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000005, \
    li  x10, 0x00000005; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    wsubu x14, x10, x12; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 7, x10, x11, 0x0000000000000000, \
    li  x10, 0x00000004; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    wsubu x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 8, x12, x13, 0x0000000000000000, \
    li  x10, 0x00000004; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    wsubu x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

