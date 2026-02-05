# See LICENSE for license details.

#*****************************************************************************
# macc_h00.S
#-----------------------------------------------------------------------------
#
# Test macc.h00 instruction (multiply-accumulate halfword 00).
# rd = rd + sext(rs1[15:0]) * sext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # macc.h00 rd, rs1, rs2: rd = rd + sext(rs1[15:0]) * sext(rs2[15:0])
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_CASE( 2, x14, 0x00000015, \
    li  x14, 0x00000000; \
    li  x1, 0x00000003; \
    li  x2, 0x00000007; \
    macc.h00 x14, x1, x2; \
  )

  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_CASE( 3, x14, 0x00000096, \
    li  x14, 0x00000064; \
    li  x1, 0x00000005; \
    li  x2, 0x0000000a; \
    macc.h00 x14, x1, x2; \
  )

  # Zero multiply: 500 + 0 * 100 = 500
  TEST_CASE( 4, x14, 0x000001f4, \
    li  x14, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00000064; \
    macc.h00 x14, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

