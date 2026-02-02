# See LICENSE for license details.

#*****************************************************************************
# saddu.S
#-----------------------------------------------------------------------------
#
# Test saddu instruction (unsigned saturating add).
# rd = SAT(rs1 + rs2) [unsigned]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: 2 + 3 = 5
  TEST_RR_OP( 2,  saddu, 0x00000005, 0x00000002, 0x00000003 );
  # 10 + 20 = 30
  TEST_RR_OP( 3,  saddu, 0x0000001e, 0x0000000a, 0x00000014 );
  
  # Saturation at max: 0xFFFFFFFF + 1 saturates to 0xFFFFFFFF
  TEST_RR_OP( 4,  saddu, 0xffffffff, 0xffffffff, 0x00000001 );
  # Saturation: 0xFFFFFFFF + 0xFFFFFFFF saturates to 0xFFFFFFFF
  TEST_RR_OP( 5,  saddu, 0xffffffff, 0xffffffff, 0xffffffff );
  # Saturation: 0x80000000 + 0x80000000 saturates to 0xFFFFFFFF
  TEST_RR_OP( 6,  saddu, 0xffffffff, 0x80000000, 0x80000000 );
  
  # No saturation: 0x7FFFFFFF + 0x7FFFFFFF = 0xFFFFFFFE
  TEST_RR_OP( 7,  saddu, 0xfffffffe, 0x7fffffff, 0x7fffffff );
  
  # Zero cases
  TEST_RR_OP( 8,  saddu, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 9,  saddu, 0x00000005, 0x00000005, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, saddu, 5, 2, 3 );
  TEST_RR_SRC2_EQ_DEST( 11, saddu, 7, 3, 4 );
  TEST_RR_SRC12_EQ_DEST( 12, saddu, 6, 3 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, saddu, 5, 2, 3 );
  TEST_RR_DEST_BYPASS( 14, 1, saddu, 7, 3, 4 );
  TEST_RR_DEST_BYPASS( 15, 2, saddu, 9, 4, 5 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, saddu, 5, 2, 3 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, saddu, 7, 3, 4 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, saddu, 9, 4, 5 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, saddu, 5, 2, 3 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, saddu, 7, 3, 4 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, saddu, 9, 4, 5 );

  TEST_RR_ZEROSRC1( 22, saddu, 5, 5 );
  TEST_RR_ZEROSRC2( 23, saddu, 5, 5 );
  TEST_RR_ZEROSRC12( 24, saddu, 0 );
  TEST_RR_ZERODEST( 25, saddu, 2, 3 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

