# See LICENSE for license details.

#*****************************************************************************
# addd.S
#-----------------------------------------------------------------------------
#
# Test addd instruction (register-pair add).
# Writes 64-bit result to rd pair (rd, rd+1)
# rd:rd+1 = rs1:rs1+1 + rs2:rs2+1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit add: 0x0000000000000004 + 0x0000000000000006 = 0x000000000000000a
  TEST_CASE_D32( 2, x14, x15, 0x000000000000000a, \
    li  x11, 0x00000004; \
    li  x12, 0x00000000; \
    li  x13, 0x00000006; \
    li  x16, 0x00000000; \
    addd x14, x11, x13; \
  )

  # 64-bit add with carry: 0x00000000ffffffff + 0x0000000000000001 = 0x0000000100000000
  TEST_CASE_D32( 3, x14, x15, 0x0000000100000000, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    addd x14, x11, x13; \
  )

  # Large 64-bit values: 0x7fffffffffffffff + 0x0000000000000001 = 0x8000000000000000
  TEST_CASE_D32( 4, x14, x15, 0x8000000000000000, \
    li  x11, 0xffffffff; \
    li  x12, 0x7fffffff; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    addd x14, x11, x13; \
  )

  # Zero cases: 0x0000000000000000 + 0x0000000000000000 = 0x0000000000000000
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    addd x14, x11, x13; \
  )

  # Negative 64-bit: 0xffffffffffffffff + 0x0000000000000001 = 0x0000000000000000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    addd x14, x11, x13; \
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
    addd x10, x10, x12; \
  )

  # Test rd = rs2 (same register pair)
  TEST_CASE_D32( 8, x12, x13, 0x0000000000000008, \
    li  x10, 0x00000004; \
    li  x11, 0x00000000; \
    li  x12, 0x00000004; \
    li  x13, 0x00000000; \
    addd x12, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

