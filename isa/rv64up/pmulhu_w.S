# See LICENSE for license details.

#*****************************************************************************
# pmulhu_w.S
#-----------------------------------------------------------------------------
#
# Test pmulhu.w instruction (packed multiply high unsigned word).
# rd[63:32] = (zext(rs1[63:32]) * zext(rs2[63:32])) >> 32
# rd[31:0] = (zext(rs1[31:0]) * zext(rs2[31:0])) >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x00010000 = 0x100000000, high = 1
  TEST_RR_OP( 2,  pmulhu.w, 0x0000000100000001, 0x0001000000010000, 0x0001000000010000 );
  
  # Multiply with larger values: 0x00100000 * 0x00100000 = 0x10000000000, high = 0x100
  TEST_RR_OP( 3,  pmulhu.w, 0x0000010000000100, 0x0010000000100000, 0x0010000000100000 );
  
  # Unsigned multiply: 0xffffffff * 0x00000001 = 0xffffffff, high = 0xffffffff
  TEST_RR_OP( 4,  pmulhu.w, 0xffffffffffffffff, 0xffffffffffffffff, 0x0000000100000001 );
  
  # Large unsigned: 0x00010000 * 0xffffffff = 0xffffffff0000, high = 0xffffffff
  TEST_RR_OP( 5,  pmulhu.w, 0xffffffffffffffff, 0x0001000000010000, 0xffffffffffffffff );
  
  # Unsigned: 0xffffffff * 0xffffffff = 0xfffffffe00000001, high = 0xfffffffe
  TEST_RR_OP( 6,  pmulhu.w, 0xfffffffefffffffe, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulhu.w, 0x0000000000000000, 0x0000000000000000, 0x0000006400000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulhu.w, 0x0000000100000001, 0x0001000000010000, 0x0001000000010000 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulhu.w, 0x0000000100000001, 0x0001000000010000, 0x0001000000010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

