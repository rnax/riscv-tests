# See LICENSE for license details.

#*****************************************************************************
# pmaxu_w.S
#-----------------------------------------------------------------------------
#
# Test pmaxu.w instruction (packed unsigned maximum words).
# For each word: rd = (rs1 > rs2) ? rs1 : rs2 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic max cases
  TEST_RR_OP( 2,  pmaxu.w, 0x0003000400030004, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_OP( 3,  pmaxu.w, 0x0003000400030004, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_OP( 4,  pmaxu.w, 0x0001000200010002, 0x0001000200010002, 0x0001000200010002 );
  
  # Mixed values
  TEST_RR_OP( 5,  pmaxu.w, 0x0001000500010005, 0x0001000500010002, 0x0001000200010005 );
  TEST_RR_OP( 6,  pmaxu.w, 0xaabbccddaabbccde, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );
  
  # High bit set (unsigned comparison differs from signed)
  TEST_RR_OP( 7,  pmaxu.w, 0x8000000180000001, 0x8000000180000001, 0x0001000200010002 );
  TEST_RR_OP( 8,  pmaxu.w, 0xfffefffdfffefffd, 0xfffefffdfffefffd, 0x0001000200010002 );
  
  # Both with high bit set
  TEST_RR_OP( 9,  pmaxu.w, 0x8000000280000002, 0x8000000180000001, 0x8000000280000002 );
  TEST_RR_OP( 10, pmaxu.w, 0xffffffffffffffff, 0xfefdfcfbfefdfcfb, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmaxu.w, 0x1234567812345678, 0x1234567812345678, 0x0000000000000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pmaxu.w, 0xabcdef00abcdef00, 0x0000000000000000, 0xabcdef00abcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pmaxu.w, 0x5555555555555555, 0x5555555555555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmaxu.w, 0x0003000400030004, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pmaxu.w, 0x0003000400030004, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pmaxu.w, 0x8000000180000001, 0x8000000180000001, 0x0001000200010002 );

  TEST_RR_ZEROSRC1( 17, pmaxu.w, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_ZEROSRC2( 18, pmaxu.w, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_ZEROSRC12( 19, pmaxu.w, 0x0000000000000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

