# See LICENSE for license details.

#*****************************************************************************
# mqacc_h00.S
#-----------------------------------------------------------------------------
#
# Test mqacc.h00 instruction (multiply-accumulate).
# rd = rd + rs1_half * rs2_half
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  # mqacc.h00 rd, rs1, rs2: rd = rd + halfword_multiply(rs1, rs2)
  #-------------------------------------------------------------

  # Basic accumulation: 0 + 3 * 7 = 21
  TEST_CASE( 2, x14, 0x00000015, \
    li  x14, 0x00000000; \
    li  x1, 0x00000003; \
    li  x2, 0x00000007; \
    mqacc.h00 x14, x1, x2; \
  )
  
  # Accumulate to existing value: 100 + 5 * 10 = 150
  TEST_CASE( 3, x14, 0x00000096, \
    li  x14, 0x00000064; \
    li  x1, 0x00000005; \
    li  x2, 0x0000000a; \
    mqacc.h00 x14, x1, x2; \
  )
  
  # Zero multiply: 500 + 0 * 100 = 500
  TEST_CASE( 4, x14, 0x000001f4, \
    li  x14, 0x000001f4; \
    li  x1, 0x00000000; \
    li  x2, 0x00000064; \
    mqacc.h00 x14, x1, x2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
