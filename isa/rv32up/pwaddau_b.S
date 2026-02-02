# See LICENSE for license details.

#*****************************************************************************
# pwaddau_b.S
#-----------------------------------------------------------------------------
#
# Test pwaddau.b instruction (packed widening unsigned add accumulate byte).
# Adds two 8-bit unsigned values and accumulates into 16-bit unsigned results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: rd=10, rs1=4, rs2=6, result=10+10=20 (0x0014 in both bytes)
  TEST_CASE( 2, x3, 0x00140014, \
    li  x3, 0x000a000a; \
    li  x1, 0x04060406; \
    pwaddau.b x3, x1, x1; \
  )

  # Accumulate with larger values: rd=0x01fe, rs1=0xff, rs2=0xff, result=0x01fe+0x01fe=0x03fc
  TEST_CASE( 3, x3, 0x03fc03fc, \
    li  x3, 0x01fe01fe; \
    li  x1, 0xffffffff; \
    pwaddau.b x3, x1, x1; \
  )

  # Accumulate: rd=0x0100, rs1=0x80, rs2=0x80, result=0x0100+0x0100=0x0200
  TEST_CASE( 4, x3, 0x02000200, \
    li  x3, 0x01000100; \
    li  x1, 0x80808080; \
    pwaddau.b x3, x1, x1; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    pwaddau.b x3, x1, x1; \
  )

  # Accumulate with different operands: rd=10, rs1=5, rs2=15, result=10+20=30
  TEST_CASE( 6, x3, 0x001e001e, \
    li  x3, 0x000a000a; \
    li  x1, 0x050f050f; \
    pwaddau.b x3, x1, x1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

