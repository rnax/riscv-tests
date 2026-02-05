# See LICENSE for license details.

#*****************************************************************************
# mulu_w00.S
#-----------------------------------------------------------------------------
#
# Test mulu.w00 instruction (multiply unsigned word bottom-bottom, 32x32->64).
# rd = zext(rs1[31:0]) * zext(rs2[31:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mulu.w00, 0x0000000000000015, 0x0000000000000003, 0x0000000000000007 );
  
  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_RR_OP( 3,  mulu.w00, 0x0000000000004e20, 0x0000000000000064, 0x00000000000000c8 );
  
  # Unsigned multiply: 0xffffffff * 0xffffffff = 0xfffffffe00000001
  TEST_RR_OP( 4,  mulu.w00, 0xfffffffe00000001, 0x00000000ffffffff, 0x00000000ffffffff );
  
  # Unsigned multiply: 0x80000000 * 2 = 0x100000000
  TEST_RR_OP( 5,  mulu.w00, 0x0000000100000000, 0x0000000080000000, 0x0000000000000002 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 6,  mulu.w00, 0x0000000000000000, 0x0000000000000000, 0x0000000000000064 );
  
  # Max 32-bit unsigned: 0xffffffff * 1 = 0xffffffff
  TEST_RR_OP( 7,  mulu.w00, 0x00000000ffffffff, 0x00000000ffffffff, 0x0000000000000001 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulu.w00, 0x0000000000000015, 3, 7 );
  TEST_RR_SRC2_EQ_DEST( 9, mulu.w00, 0x0000000000000023, 5, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

