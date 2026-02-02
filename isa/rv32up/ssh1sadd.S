# See LICENSE for license details.

#*****************************************************************************
# ssh1sadd.S
#-----------------------------------------------------------------------------
#
# Test ssh1sadd instruction (shift left 1 and saturating add).
# rd = SAT((rs1 << 1) + rs2)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: ((2 << 1) + 3) = 7
  TEST_RR_OP( 2,  ssh1sadd, 0x00000007, 0x00000002, 0x00000003 );
  # ((5 << 1) + 10) = 20
  TEST_RR_OP( 3,  ssh1sadd, 0x00000014, 0x00000005, 0x0000000a );
  
  # Saturation at max positive: ((0x40000000 << 1) + 1) saturates to 0x7FFFFFFF
  TEST_RR_OP( 4,  ssh1sadd, 0x7fffffff, 0x40000000, 0x00000001 );
  # Saturation at min negative: ((0xc0000000 << 1) + 0) saturates to 0x80000000
  TEST_RR_OP( 5,  ssh1sadd, 0x80000000, 0xc0000000, 0x00000000 );
  
  # Negative operands: (((-2) << 1) + (-3)) = -7
  TEST_RR_OP( 6,  ssh1sadd, 0xfffffff9, 0xfffffffe, 0xfffffffd );
  # (((-5) << 1) + (-10)) = -20
  TEST_RR_OP( 7,  ssh1sadd, 0xffffffec, 0xfffffffb, 0xfffffff6 );
  
  # Zero cases
  TEST_RR_OP( 8,  ssh1sadd, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 9,  ssh1sadd, 0x00000005, 0x00000000, 0x00000005 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, ssh1sadd, 7, 2, 3 );
  TEST_RR_SRC2_EQ_DEST( 11, ssh1sadd, 9, 3, 3 );
  TEST_RR_SRC12_EQ_DEST( 12, ssh1sadd, 6, 2 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, ssh1sadd, 7, 2, 3 );
  TEST_RR_DEST_BYPASS( 14, 1, ssh1sadd, 9, 3, 3 );
  TEST_RR_DEST_BYPASS( 15, 2, ssh1sadd, 11, 4, 3 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, ssh1sadd, 7, 2, 3 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, ssh1sadd, 9, 3, 3 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, ssh1sadd, 11, 4, 3 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, ssh1sadd, 7, 2, 3 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, ssh1sadd, 9, 3, 3 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, ssh1sadd, 11, 4, 3 );

  TEST_RR_ZEROSRC1( 22, ssh1sadd, 5, 5 );
  TEST_RR_ZEROSRC2( 23, ssh1sadd, 4, 4 );
  TEST_RR_ZEROSRC12( 24, ssh1sadd, 0 );
  TEST_RR_ZERODEST( 25, ssh1sadd, 2, 3 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

