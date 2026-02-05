# See LICENSE for license details.

#*****************************************************************************
# psub_dh.S
#-----------------------------------------------------------------------------
#
# Test psub.dh instruction (packed subtract double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = rs1:rs1+1 - rs2:rs2+1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic 64-bit subtract: 0x000a000a - 0x00040004 = 0x00060006
  TEST_CASE_D32( 2, x14, x15, 0x0006000600060006, \
    li  x10, 0x000a000a; \
    li  x11, 0x000a000a; \
    li  x12, 0x00040004; \
    li  x13, 0x00040004; \
    psub.dh x14, x10, x12; \
  )

  # Negative result: 0x00040004 - 0x000a000a = 0xfffafffa
  TEST_CASE_D32( 3, x14, x15, 0xfffafffffffffffa, \
    li  x10, 0x00040004; \
    li  x11, 0x00040004; \
    li  x12, 0x000a000a; \
    li  x13, 0x000a000a; \
    psub.dh x14, x10, x12; \
  )

  # Zero cases: 0x0000 - 0x0000 = 0x0000
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    psub.dh x14, x10, x12; \
  )

  # Large positive: 0x7fff7fff - 0x00010001 = 0x7ffe7ffe
  TEST_CASE_D32( 5, x14, x15, 0x7ffe7ffe7ffe7ffe, \
    li  x10, 0x7fff7fff; \
    li  x11, 0x7fff7fff; \
    li  x12, 0x00010001; \
    li  x13, 0x00010001; \
    psub.dh x14, x10, x12; \
  )

  # Same values: 0xaaaa - 0xaaaa = 0x0000
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x10, 0xaaaaaaaa; \
    li  x11, 0xaaaaaaaa; \
    li  x12, 0xaaaaaaaa; \
    li  x13, 0xaaaaaaaa; \
    psub.dh x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

