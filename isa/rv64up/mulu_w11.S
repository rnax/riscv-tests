# See LICENSE for license details.

#*****************************************************************************
# mulu_w11.S
#-----------------------------------------------------------------------------
#
# Test mulu.w11 instruction (multiply unsigned word top-top, 32x32->64).
# rd = zext(rs1[63:32]) * zext(rs2[63:32])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mulu.w11, 0x0000000000000015, 0x0000000300000000, 0x0000000700000000 );
  
  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_RR_OP( 3,  mulu.w11, 0x0000000000004e20, 0x0000000064000000, 0x00000000c8000000 );
  
  # Unsigned multiply: 0xffffffff * 0xffffffff = 0xfffffffe00000001
  TEST_RR_OP( 4,  mulu.w11, 0xfffffffe00000001, 0xffffffff00000000, 0xffffffff00000000 );
  
  # Unsigned multiply: 0x80000000 * 2 = 0x100000000
  TEST_RR_OP( 5,  mulu.w11, 0x0000000100000000, 0x8000000000000000, 0x0000000200000000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 6,  mulu.w11, 0x0000000000000000, 0x0000000000000000, 0x0000000064000000 );
  
  # Max 32-bit unsigned: 0xffffffff * 1 = 0xffffffff
  TEST_RR_OP( 7,  mulu.w11, 0x00000000ffffffff, 0xffffffff00000000, 0x0000000100000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulu.w11, 0x0000000000000015, 0x0300000000, 0x0700000000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulu.w11, 0x0000000000000023, 0x0500000000, 0x0700000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

