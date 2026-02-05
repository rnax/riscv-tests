# See LICENSE for license details.

#*****************************************************************************
# subd.S
#-----------------------------------------------------------------------------
#
# Test subd instruction (register-pair subtract).
# Writes 64-bit result to rd pair (rd, rd+1)
# rd:rd+1 = rs1:rs1+1 - rs2:rs2+1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit subtract: 0x000000000000000a - 0x0000000000000004 = 0x0000000000000006
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000006, \
    li  x10, 0x0000000a; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    subd x14, x10, x12; \
  )

  # 64-bit subtract with borrow: 0x0000000100000000 - 0x0000000000000001 = 0x00000000ffffffff
  TEST_CASE_D32( 3, x14, x15, 0x00000000ffffffff, \
    li  x10, 0x00000000; \
    li  x11, 0x00000001; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    subd x14, x10, x12; \
  )

  # Large 64-bit values: 0x8000000000000000 - 0x0000000000000001 = 0x7fffffffffffffff
  TEST_CASE_D32( 4, x14, x15, 0x7fffffffffffffff, \
    li  x10, 0x00000000; \
    li  x11, 0x80000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    subd x14, x10, x12; \
  )

  # Zero cases: 0x0000000000000000 - 0x0000000000000000 = 0x0000000000000000
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    subd x14, x10, x12; \
  )

  # Negative result: 0x0000000000000000 - 0x0000000000000001 = 0xffffffffffffffff
  TEST_CASE_D32( 6, x14, x15, 0xffffffffffffffff, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    subd x14, x10, x12; \
  )

  # Subtract same value: 0x00000000ffffffff - 0x00000000ffffffff = 0x0000000000000000
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0xffffffff; \
    li  x13, 0x00000000; \
    subd x14, x10, x12; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 8, x10, x11, 0x0000000000000000, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000008; \
    li  x12, 0x00000000; \
    subd x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 9, x12, x13, 0x0000000000000000, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000008; \
    li  x12, 0x00000000; \
    subd x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

