# See LICENSE for license details.

#*****************************************************************************
# mulsu_w11.S
#-----------------------------------------------------------------------------
#
# Test mulsu.w11 instruction (multiply signed*unsigned word top-top).
# rd = sext(rs1[63:32]) * zext(rs2[63:32])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic positive multiply: 3 * 7 = 21
  TEST_RR_OP( 2,  mulsu.w11, 0x0000000000000015, 0x0000000300000000, 0x0000000700000000 );
  
  # Larger positive: 100 * 200 = 20000 (0x4E20)
  TEST_RR_OP( 3,  mulsu.w11, 0x0000000000004e20, 0x0000000064000000, 0x00000000c8000000 );
  
  # Signed negative * unsigned: -5 * 10 = -50
  TEST_RR_OP( 4,  mulsu.w11, 0xffffffffffffffce, 0xfffffffffffffffb00000000, 0x000000000a000000 );
  
  # Signed negative * unsigned large: -1 * 0xffffffff = -0xffffffff
  TEST_RR_OP( 5,  mulsu.w11, 0xffffffff00000001, 0xffffffffffffffff00000000, 0x00000000ffffffff00000000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 6,  mulsu.w11, 0x0000000000000000, 0x0000000000000000, 0x0000000064000000 );
  
  # Max 32-bit signed * max unsigned: 0x7fffffff * 0xffffffff
  TEST_RR_OP( 7,  mulsu.w11, 0x7ffffffe80000001, 0x000000007fffffff00000000, 0x00000000ffffffff00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulsu.w11, 0x0000000000000015, 0x0300000000, 0x0700000000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulsu.w11, 0x0000000000000023, 0x0500000000, 0x0700000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

