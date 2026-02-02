# See LICENSE for license details.

#*****************************************************************************
# psaddu_dh.S
#-----------------------------------------------------------------------------
#
# Test psaddu.dh instruction (packed unsigned saturating add double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 + rs2:rs2+1)
# 4 elements of 16-bits each, unsigned with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic add: 100 + 200 = 300 for each halfword
  TEST_CASE_D32( 2, x14, x15, 0x012c012c012c012c, \
    li  x11, 0x00640064; \
    li  x12, 0x00000000; \
    li  x13, 0x00c800c8; \
    li  x16, 0x00000000; \
    psaddu.dh x14, x11, x13; \
  )

  # Saturation at max unsigned: 40000 + 30000 = 70000 (saturates to 65535)
  TEST_CASE_D32( 3, x14, x15, 0xffffffffffffffff, \
    li  x11, 0x9c409c40; \
    li  x12, 0x00000000; \
    li  x13, 0x75307530; \
    li  x16, 0x00000000; \
    psaddu.dh x14, x11, x13; \
  )

  # No saturation: 20000 + 20000 = 40000
  TEST_CASE_D32( 4, x14, x15, 0x9c409c409c409c40, \
    li  x11, 0x4e204e20; \
    li  x12, 0x00000000; \
    li  x13, 0x4e204e20; \
    li  x16, 0x00000000; \
    psaddu.dh x14, x11, x13; \
  )

  # Zero cases
  TEST_CASE_D32( 5, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    psaddu.dh x14, x11, x13; \
  )

  # Mixed values: 1000 + 500 = 1500
  TEST_CASE_D32( 6, x14, x15, 0x05dc05dc05dc05dc, \
    li  x11, 0x03e803e8; \
    li  x12, 0x00000000; \
    li  x13, 0x01f401f4; \
    li  x16, 0x00000000; \
    psaddu.dh x14, x11, x13; \
  )

  # Large values: 65535 + 1 = 65536 (saturates to 65535)
  TEST_CASE_D32( 7, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0x00000000; \
    li  x13, 0x00010001; \
    li  x16, 0x00000000; \
    psaddu.dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

