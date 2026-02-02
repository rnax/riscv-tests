# See LICENSE for license details.

#*****************************************************************************
# ssub.S
#-----------------------------------------------------------------------------
#
# Test ssub instruction (signed saturating subtract).
# rd = SAT(rs1 - rs2) [signed]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 5 - 3 = 2
  TEST_RR_OP( 2,  ssub, 0x00000002, 0x00000005, 0x00000003 );
  # 20 - 10 = 10
  TEST_RR_OP( 3,  ssub, 0x0000000a, 0x00000014, 0x0000000a );
  
  # Saturation at max positive: 0x7FFFFFFF - (-1) saturates to 0x7FFFFFFF
  TEST_RR_OP( 4,  ssub, 0x7fffffff, 0x7fffffff, 0xffffffff );
  # Saturation at min negative: 0x80000000 - 1 saturates to 0x80000000
  TEST_RR_OP( 5,  ssub, 0x80000000, 0x80000000, 0x00000001 );
  
  # Negative operands: (-5) - (-3) = -2
  TEST_RR_OP( 6,  ssub, 0xfffffffe, 0xfffffffb, 0xfffffffd );
  # (-20) - (-10) = -10
  TEST_RR_OP( 7,  ssub, 0xfffffff6, 0xffffffec, 0xfffffff6 );
  
  # Zero cases
  TEST_RR_OP( 8,  ssub, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 9,  ssub, 0x00000005, 0x00000005, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, ssub, 2, 5, 3 );
  TEST_RR_SRC2_EQ_DEST( 11, ssub, 1, 4, 3 );
  TEST_RR_SRC12_EQ_DEST( 12, ssub, 0, 5 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, ssub, 2, 5, 3 );
  TEST_RR_DEST_BYPASS( 14, 1, ssub, 1, 4, 3 );
  TEST_RR_DEST_BYPASS( 15, 2, ssub, 0, 3, 3 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, ssub, 2, 5, 3 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, ssub, 1, 4, 3 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, ssub, 0, 3, 3 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, ssub, 2, 5, 3 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, ssub, 1, 4, 3 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, ssub, 0, 3, 3 );

  TEST_RR_ZEROSRC1( 22, ssub, 0, 5 );
  TEST_RR_ZEROSRC2( 23, ssub, 5, 5 );
  TEST_RR_ZEROSRC12( 24, ssub, 0 );
  TEST_RR_ZERODEST( 25, ssub, 5, 3 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

