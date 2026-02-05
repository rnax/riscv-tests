# See LICENSE for license details.

#*****************************************************************************
# pminu_w.S
#-----------------------------------------------------------------------------
#
# Test pminu.w instruction (packed unsigned minimum words).
# For each word: rd = (rs1 < rs2) ? rs1 : rs2 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pminu.w, 0x0001000200010002, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_OP( 3,  pminu.w, 0x0001000200010002, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_OP( 4,  pminu.w, 0x0001000200010002, 0x0001000200010002, 0x0001000200010002 );
  
  # Mixed values
  TEST_RR_OP( 5,  pminu.w, 0x0001000200010002, 0x0001000500010002, 0x0001000200010005 );
  TEST_RR_OP( 6,  pminu.w, 0xaabbccddaabbccdd, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );
  
  # High bit set (unsigned comparison differs from signed)
  TEST_RR_OP( 7,  pminu.w, 0x0001000200010002, 0x8000000180000001, 0x0001000200010002 );
  TEST_RR_OP( 8,  pminu.w, 0x0001000200010002, 0xfffefffdfffefffd, 0x0001000200010002 );
  
  # Both with high bit set
  TEST_RR_OP( 9,  pminu.w, 0x8000000180000001, 0x8000000180000001, 0x8000000280000002 );
  TEST_RR_OP( 10, pminu.w, 0xfffefffdfffefffd, 0xfffefffdfffefffd, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pminu.w, 0x1234567812345678, 0x1234567812345678, 0x0000000000000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pminu.w, 0x0000000000000000, 0x0000000000000000, 0xabcdef00abcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pminu.w, 0x5555555555555555, 0x5555555555555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pminu.w, 0x0001000200010002, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pminu.w, 0x0001000200010002, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pminu.w, 0x0001000200010002, 0x8000000180000001, 0x0001000200010002 );

  TEST_RR_ZEROSRC1( 17, pminu.w, 0x0000000000000000, 0x1234567812345678 );
  TEST_RR_ZEROSRC2( 18, pminu.w, 0x0000000000000000, 0x1234567812345678 );
  TEST_RR_ZEROSRC12( 19, pminu.w, 0x0000000000000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

