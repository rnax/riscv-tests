# See LICENSE for license details.

#*****************************************************************************
# wsubau.S
#-----------------------------------------------------------------------------
#
# Test wsubau instruction (widening unsigned subtract accumulate to register-pair).
# rd:rd+1 = rd:rd+1 + (uint64_t)rs1 - (uint64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned accumulate subtract: 20 + 10 - 4 = 26
  TEST_CASE_D32( 2, x14, x15, 0x000000000000001a, \
    li  x14, 0x00000014; \
    li  x15, 0x00000000; \
    li  x10, 0x0000000a; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    wsubau x14, x10, x12; \
  )

  # Unsigned accumulate subtract with large values: 0xffffffff + 0xffffffff - 0x00000001 = 0x1fffffffd
  TEST_CASE_D32( 3, x14, x15, 0x00000001fffffffd, \
    li  x14, 0xffffffff; \
    li  x15, 0x00000000; \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    wsubau x14, x10, x12; \
  )

  # Unsigned accumulate subtract with borrow: 10 + 5 - 20 = -5 (as unsigned)
  TEST_CASE_D32( 4, x14, x15, 0xfffffffffffffffb, \
    li  x14, 0x0000000a; \
    li  x15, 0x00000000; \
    li  x10, 0x00000005; \
    li  x11, 0x00000000; \
    li  x12, 0x00000014; \
    li  x13, 0x00000000; \
    wsubau x14, x10, x12; \
  )

  # Zero unsigned accumulate subtract: 5 + 0 - 0 = 5
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000005, \
    li  x14, 0x00000005; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    wsubau x14, x10, x12; \
  )

  # Large unsigned accumulate subtract: 0x80000000 + 0x80000000 - 0x80000000 = 0x80000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000080000000, \
    li  x14, 0x80000000; \
    li  x15, 0x00000000; \
    li  x10, 0x80000000; \
    li  x11, 0x00000000; \
    li  x12, 0x80000000; \
    li  x13, 0x00000000; \
    wsubau x14, x10, x12; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 7, x10, x11, 0x0000000000000008, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    wsubau x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 8, x12, x13, 0x0000000000000008, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    wsubau x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

