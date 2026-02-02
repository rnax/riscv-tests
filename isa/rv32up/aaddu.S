# See LICENSE for license details.

#*****************************************************************************
# aaddu.S
#-----------------------------------------------------------------------------
#
# Test aaddu instruction (unsigned averaging add).
# rd = ((uint64_t)rs1 + (uint64_t)rs2) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic unsigned averaging add: (4 + 6) >> 1 = 5
  TEST_RR_OP( 2,  aaddu, 0x00000005, 0x00000004, 0x00000006 );
  # (10 + 20) >> 1 = 15
  TEST_RR_OP( 3,  aaddu, 0x0000000f, 0x0000000a, 0x00000014 );
  # Odd sum: (3 + 4) >> 1 = 3 (truncated)
  TEST_RR_OP( 4,  aaddu, 0x00000003, 0x00000003, 0x00000004 );
  
  # Large unsigned: (0xFFFFFFFF + 1) >> 1 = 0x80000000
  TEST_RR_OP( 5,  aaddu, 0x80000000, 0xffffffff, 0x00000001 );
  # (0xFFFFFFFF + 0xFFFFFFFF) >> 1 = 0xFFFFFFFF
  TEST_RR_OP( 6,  aaddu, 0xffffffff, 0xffffffff, 0xffffffff );
  # (0x80000000 + 0x80000000) >> 1 = 0x80000000
  TEST_RR_OP( 7,  aaddu, 0x80000000, 0x80000000, 0x80000000 );
  
  # Zero cases
  TEST_RR_OP( 8,  aaddu, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RR_OP( 9,  aaddu, 0x7fffffff, 0xffffffff, 0x00000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, aaddu, 5, 4, 6 );
  TEST_RR_SRC2_EQ_DEST( 11, aaddu, 7, 6, 8 );
  TEST_RR_SRC12_EQ_DEST( 12, aaddu, 10, 10 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, aaddu, 5, 4, 6 );
  TEST_RR_DEST_BYPASS( 14, 1, aaddu, 7, 6, 8 );
  TEST_RR_DEST_BYPASS( 15, 2, aaddu, 9, 8, 10 );

  TEST_RR_SRC12_BYPASS( 16, 0, 0, aaddu, 5, 4, 6 );
  TEST_RR_SRC12_BYPASS( 17, 0, 1, aaddu, 7, 6, 8 );
  TEST_RR_SRC12_BYPASS( 18, 0, 2, aaddu, 9, 8, 10 );
  TEST_RR_SRC12_BYPASS( 19, 1, 0, aaddu, 5, 4, 6 );
  TEST_RR_SRC12_BYPASS( 20, 1, 1, aaddu, 7, 6, 8 );
  TEST_RR_SRC12_BYPASS( 21, 2, 0, aaddu, 9, 8, 10 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

