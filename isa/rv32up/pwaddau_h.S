# See LICENSE for license details.

#*****************************************************************************
# pwaddau_h.S
#-----------------------------------------------------------------------------
#
# Test pwaddau.h instruction (packed widening unsigned add accumulate halfword).
# Adds two 16-bit unsigned values and accumulates into 32-bit unsigned results.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic accumulate: rd=10, rs1=4, rs2=6, result=10+10=20
  TEST_CASE( 2, x3, 0x00000014, \
    li  x3, 0x0000000a; \
    li  x1, 0x00040006; \
    pwaddau.h x3, x1, x1; \
  )

  # Accumulate with larger values: rd=0x0001fffe, rs1=0xffff, rs2=0xffff, result=0x0001fffe+0x0001fffe=0x0003fffc
  TEST_CASE( 3, x3, 0x0003fffc, \
    li  x3, 0x0001fffe; \
    li  x1, 0xffffffff; \
    pwaddau.h x3, x1, x1; \
  )

  # Accumulate: rd=0x00010000, rs1=0x8000, rs2=0x8000, result=0x00010000+0x00010000=0x00020000
  TEST_CASE( 4, x3, 0x00020000, \
    li  x3, 0x00010000; \
    li  x1, 0x80008000; \
    pwaddau.h x3, x1, x1; \
  )

  # Accumulate zero: rd=0, rs1=0, rs2=0, result=0
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000000; \
    pwaddau.h x3, x1, x1; \
  )

  # Accumulate with different operands: rd=10, rs1=5, rs2=15, result=10+20=30
  TEST_CASE( 6, x3, 0x0000001e, \
    li  x3, 0x0000000a; \
    li  x1, 0x0005000f; \
    pwaddau.h x3, x1, x1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

