# See LICENSE for license details.

#*****************************************************************************
# waddau.S
#-----------------------------------------------------------------------------
#
# Test waddau instruction (widening unsigned add accumulate to register-pair).
# rd:rd+1 = rd:rd+1 + (uint64_t)rs1 + (uint64_t)rs2
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned accumulate: 10 + 4 + 6 = 20
  TEST_CASE_D32( 2, x14, x15, 0x0000000000000014, \
    li  x14, 0x0000000a; \
    li  x15, 0x00000000; \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x00000006; \
    li  x13, 0x00000000; \
    waddau x14, x10, x12; \
  )

  # Unsigned accumulate with large values: 0xffffffff + 0xffffffff + 0xffffffff = 0x2fffffffd
  TEST_CASE_D32( 3, x14, x15, 0x00000002fffffffd, \
    li  x14, 0xffffffff; \
    li  x15, 0x00000000; \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0xffffffff; \
    li  x13, 0x00000000; \
    waddau x14, x10, x12; \
  )

  # Unsigned accumulate with carry: 0xffffffff + 0xffffffff + 0x00000001 = 0x1ffffffff
  TEST_CASE_D32( 4, x14, x15, 0x00000001ffffffff, \
    li  x14, 0xffffffff; \
    li  x15, 0x00000000; \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    waddau x14, x10, x12; \
  )

  # Zero accumulate: 5 + 0 + 0 = 5
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000005, \
    li  x14, 0x00000005; \
    li  x15, 0x00000000; \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    waddau x14, x10, x12; \
  )

  # Large unsigned accumulate: 0x80000000 + 0x80000000 + 0x80000000 = 0x180000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000180000000, \
    li  x14, 0x80000000; \
    li  x15, 0x00000000; \
    li  x10, 0x80000000; \
    li  x11, 0x00000000; \
    li  x12, 0x80000000; \
    li  x13, 0x00000000; \
    waddau x14, x10, x12; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  # Test rd = rs1 (same register pair)
  TEST_CASE_D32( 7, x10, x11, 0x0000000000000010, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    waddau x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 8, x12, x13, 0x0000000000000010, \
    li  x10, 0x00000008; \
    li  x10, 0x00000000; \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    waddau x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

