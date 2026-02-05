# See LICENSE for license details.

#*****************************************************************************
# pmulq_w.S
#-----------------------------------------------------------------------------
#
# Test pmulq.w instruction (packed Q-format multiply word).
# rd[63:32] = (sext(rs1[63:32]) * sext(rs2[63:32])) << 1 >> 32
# rd[31:0] = (sext(rs1[31:0]) * sext(rs2[31:0])) << 1 >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x00010000 = 0x100000000, Q-format = 0x2
  TEST_RR_OP( 2,  pmulq.w, 0x0000000200000002, 0x0001000000010000, 0x0001000000010000 );
  
  # Multiply with larger values: 0x00100000 * 0x00100000 = 0x10000000000, Q-format = 0x200
  TEST_RR_OP( 3,  pmulq.w, 0x0000020000000200, 0x0010000000100000, 0x0010000000100000 );
  
  # Negative multiply: 0xffffffff * 0x00000001 = 0xffffffff, Q-format = 0xfffffffe
  TEST_RR_OP( 4,  pmulq.w, 0xfffffffefffffffe, 0xffffffffffffffff, 0x0000000100000001 );
  
  # Mixed signs: 0x00010000 * 0xffffffff = 0xffffffff0000, Q-format = 0xfffffffe0000
  TEST_RR_OP( 5,  pmulq.w, 0xfffffffefffffffe, 0x0001000000010000, 0xffffffffffffffff );
  
  # Negative result: 0xffffffff * 0xffffffff = 0x1, Q-format = 0x2
  TEST_RR_OP( 6,  pmulq.w, 0x0000000200000002, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulq.w, 0x0000000000000000, 0x0000000000000000, 0x0000006400000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulq.w, 0x0000000200000002, 0x0001000000010000, 0x0001000000010000 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulq.w, 0x0000000200000002, 0x0001000000010000, 0x0001000000010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

