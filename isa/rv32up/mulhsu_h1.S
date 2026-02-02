# See LICENSE for license details.

#*****************************************************************************
# mulhsu_h1.S
#-----------------------------------------------------------------------------
#
# Test mulhsu.h1 instruction (high multiply signed*unsigned halfword 1).
# rd = (sext(rs1) * zext(rs2[31:16])) >> 32
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x0001 = 0x0000000100000000, high = 1
  TEST_RR_OP( 2,  mulhsu.h1, 0x00000001, 0x00010000, 0x00010000 );
  
  # Multiply with larger values: 0x00100000 * 0x0100 = 0x0010000000000, high = 0x1000
  TEST_RR_OP( 3,  mulhsu.h1, 0x00001000, 0x00100000, 0x01000000 );
  
  # Negative signed, positive unsigned: 0xffffffff * 0x0001 = 0xffffffffffffffff, high = 0xffffffff
  TEST_RR_OP( 4,  mulhsu.h1, 0xffffffff, 0xffffffff, 0x00010000 );
  
  # Halfword selection (upper 16 bits of rs2): 0x00010000 * 0x1234 = 0x12340000, high = 0
  TEST_RR_OP( 5,  mulhsu.h1, 0x00000000, 0x00010000, 0x12340000 );
  
  # Negative signed, positive unsigned: 0xffffffff * 0xffff = 0xffffffff0001, high = 0xffffffff
  TEST_RR_OP( 6,  mulhsu.h1, 0xffffffff, 0xffffffff, 0xffff0000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  mulhsu.h1, 0x00000000, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulhsu.h1, 1, 0x00010000, 0x00010000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulhsu.h1, 1, 0x00010000, 0x00010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

