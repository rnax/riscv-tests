# See LICENSE for license details.

#*****************************************************************************
# pmsltu_w.S
#-----------------------------------------------------------------------------
#
# Test pmsltu.w instruction (packed mask set less than unsigned words).
# For each word: rd = (rs1 < rs2) ? 0xFFFFFFFF : 0x00000000 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Both words less than
  TEST_RR_OP( 2,  pmsltu.w, 0xffffffffffffffff, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_OP( 3,  pmsltu.w, 0xffffffffffffffff, 0x0000000000000000, 0x0001000200010002 );
  
  # One word less than
  TEST_RR_OP( 4,  pmsltu.w, 0xffffffff00000000, 0x0001000200030004, 0x0003000400030004 );
  TEST_RR_OP( 5,  pmsltu.w, 0x00000000ffffffff, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );
  
  # No words less than
  TEST_RR_OP( 6,  pmsltu.w, 0x0000000000000000, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_OP( 7,  pmsltu.w, 0x0000000000000000, 0x0001000200010002, 0x0001000200010002 );
  
  # High bit set (unsigned comparison differs from signed)
  TEST_RR_OP( 8,  pmsltu.w, 0xffffffffffffffff, 0x0001000200010002, 0x8000000180000001 );
  TEST_RR_OP( 9,  pmsltu.w, 0x0000000000000000, 0x8000000180000001, 0x0001000200010002 );
  
  # Both with high bit set
  TEST_RR_OP( 10, pmsltu.w, 0xffffffffffffffff, 0x8000000180000001, 0x8000000280000002 );
  TEST_RR_OP( 11, pmsltu.w, 0x0000000000000000, 0xfffefffdfffefffd, 0xfffefffdfffefffd );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 12, pmsltu.w, 0x0000000000000000, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_SRC2_EQ_DEST( 13, pmsltu.w, 0x0000000000000000, 0xaabbccddaabbccdd, 0xaabbccddaabbccdd );
  TEST_RR_SRC12_EQ_DEST( 14, pmsltu.w, 0x0000000000000000, 0x5555555555555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 15, 0, pmsltu.w, 0xffffffffffffffff, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_DEST_BYPASS( 16, 1, pmsltu.w, 0x0000000000000000, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_DEST_BYPASS( 17, 2, pmsltu.w, 0xffffffffffffffff, 0x0001000200010002, 0x8000000180000001 );

  TEST_RR_ZEROSRC1( 18, pmsltu.w, 0xffffffffffffffff, 0x0001000200010002 );
  TEST_RR_ZEROSRC2( 19, pmsltu.w, 0x0000000000000000, 0x0001000200010002 );
  TEST_RR_ZEROSRC12( 20, pmsltu.w, 0x0000000000000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

