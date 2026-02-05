# See LICENSE for license details.

#*****************************************************************************
# pmax_w.S
#-----------------------------------------------------------------------------
#
# Test pmax.w instruction (packed signed maximum words).
# For each word: rd = (rs1 > rs2) ? rs1 : rs2 (signed comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic max cases
  TEST_RR_OP( 2,  pmax.w, 0x0003000400030004, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_OP( 3,  pmax.w, 0x0003000400030004, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_OP( 4,  pmax.w, 0x0001000200010002, 0x0001000200010002, 0x0001000200010002 );
  
  # Mixed values
  TEST_RR_OP( 5,  pmax.w, 0x0001000500010005, 0x0001000500010002, 0x0001000200010005 );
  TEST_RR_OP( 6,  pmax.w, 0xaabbccddaabbccde, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );
  
  # Negative vs positive
  TEST_RR_OP( 7,  pmax.w, 0x0001000200010002, 0x8000000180000001, 0x0001000200010002 );
  TEST_RR_OP( 8,  pmax.w, 0x0001020300010203, 0xfefdfcfbfefdfcfb, 0x0001020300010203 );
  
  # Negative vs negative
  TEST_RR_OP( 9,  pmax.w, 0x8000000280000002, 0x8000000180000001, 0x8000000280000002 );
  TEST_RR_OP( 10, pmax.w, 0xffffffffffffffff, 0xfefdfcfbfefdfcfb, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmax.w, 0x1234567812345678, 0x1234567812345678, 0x0000000000000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pmax.w, 0xabcdef00abcdef00, 0x0000000000000000, 0xabcdef00abcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pmax.w, 0x5555555555555555, 0x5555555555555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmax.w, 0x0003000400030004, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pmax.w, 0x0003000400030004, 0x0003000400030004, 0x0001000200010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pmax.w, 0x0001000200010002, 0x8000000180000001, 0x0001000200010002 );

  TEST_RR_ZEROSRC1( 17, pmax.w, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_ZEROSRC2( 18, pmax.w, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_ZEROSRC12( 19, pmax.w, 0x0000000000000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

