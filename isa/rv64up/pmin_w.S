# See LICENSE for license details.

#*****************************************************************************
# pmin_w.S
#-----------------------------------------------------------------------------
#
# Test pmin.w instruction (packed signed minimum words).
# For each word: rd = (rs1 < rs2) ? rs1 : rs2 (signed comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pmin.w, 0x0001000200010002, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_OP( 3,  pmin.w, 0x0001000200010002, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_OP( 4,  pmin.w, 0x0001000200010002, 0x0001000200010002, 0x0001000200010002 );
  
  # Mixed values
  TEST_RR_OP( 5,  pmin.w, 0x0001000200010002, 0x0001000500010002, 0x0001000200010005 );
  TEST_RR_OP( 6,  pmin.w, 0xaabbccddaabbccdd, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );
  
  # Negative vs positive
  TEST_RR_OP( 7,  pmin.w, 0x8000000180000001, 0x8000000180000001, 0x0001000200010002 );
  TEST_RR_OP( 8,  pmin.w, 0xfffefffdfffefffd, 0xfffefffdfffefffd, 0x0001000200010002 );
  
  # Negative vs negative
  TEST_RR_OP( 9,  pmin.w, 0x8000000180000001, 0x8000000180000001, 0x8000000280000002 );
  TEST_RR_OP( 10, pmin.w, 0xfffefffdfffefffd, 0xfffefffdfffefffd, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmin.w, 0x1234567812345678, 0x1234567812345678, 0x0000000000000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pmin.w, 0x0000000000000000, 0x0000000000000000, 0xabcdef00abcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pmin.w, 0x5555555555555555, 0x5555555555555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmin.w, 0x0001000200010002, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pmin.w, 0x0001000200010002, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pmin.w, 0x8000000180000001, 0x8000000180000001, 0x0001000200010002 );

  TEST_RR_ZEROSRC1( 17, pmin.w, 0x0000000000000000, 0x1234567812345678 );
  TEST_RR_ZEROSRC2( 18, pmin.w, 0x0000000000000000, 0x1234567812345678 );
  TEST_RR_ZEROSRC12( 19, pmin.w, 0x0000000000000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

