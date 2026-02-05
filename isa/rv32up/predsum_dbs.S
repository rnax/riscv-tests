# See LICENSE for license details.

#*****************************************************************************
# predsum_dbs.S
#-----------------------------------------------------------------------------
#
# Test predsum.dbs instruction (packed reduction sum).
# rd = rs2 + sum(rs1:rs1+1) as signed elements
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum tests (uses register pairs - even registers)
  #-------------------------------------------------------------

  # Basic sum starting from 0
  TEST_CASE( 2, x14, 0x00000024, \
    li  x10, 0x04030201; \
    li  x11, 0x08070605; \
    li  x12, 0x00000000; \
    predsum.dbs x14, x10, x12; \
  )

  # All zeros
  TEST_CASE( 3, x14, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    predsum.dbs x14, x10, x12; \
  )

  # Accumulate to existing value
  TEST_CASE( 4, x14, 0x00000032, \
    li  x10, 0x01010101; \
    li  x11, 0x01010101; \
    li  x12, 0x0000002a; \
    predsum.dbs x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
