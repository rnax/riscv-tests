# See LICENSE for license details.

#*****************************************************************************
# pmulhrsu_w.S
#-----------------------------------------------------------------------------
#
# Test pmulhrsu.w instruction (packed multiply high with rounding signed*unsigned word).
# rd[63:32] = ((sext(rs1[63:32]) * zext(rs2[63:32])) >> 31) + 1) >> 1
# rd[31:0] = ((sext(rs1[31:0]) * zext(rs2[31:0])) >> 31) + 1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x00010000 = 0x100000000
  TEST_RR_OP( 2,  pmulhrsu.w, 0x0000000100000001, 0x0001000000010000, 0x0001000000010000 );
  
  # Multiply with larger values: 0x00100000 * 0x00100000 = 0x10000000000
  TEST_RR_OP( 3,  pmulhrsu.w, 0x0000010000000100, 0x0010000000100000, 0x0010000000100000 );
  
  # Signed * Unsigned: 0xffffffff * 0x00000001 = 0xffffffff
  TEST_RR_OP( 4,  pmulhrsu.w, 0xffffffffffffffff, 0xffffffffffffffff, 0x0000000100000001 );
  
  # Mixed: 0x00010000 * 0xffffffff (unsigned) = 0xffffffff0000
  TEST_RR_OP( 5,  pmulhrsu.w, 0xffffffffffffffff, 0x0001000000010000, 0xffffffffffffffff );
  
  # Negative signed: 0xffffffff * 0xffffffff (unsigned) = 0xffffffff00000001
  TEST_RR_OP( 6,  pmulhrsu.w, 0xffffffff00000000, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulhrsu.w, 0x0000000000000000, 0x0000000000000000, 0x0000006400000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulhrsu.w, 0x0000000100000001, 0x0001000000010000, 0x0001000000010000 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulhrsu.w, 0x0000000100000001, 0x0001000000010000, 0x0001000000010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

