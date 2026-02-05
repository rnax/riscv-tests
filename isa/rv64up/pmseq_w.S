# See LICENSE for license details.

#*****************************************************************************
# pmseq_w.S
#-----------------------------------------------------------------------------
#
# Test pmseq.w instruction (packed mask set equal words).
# For each word: rd = (rs1 == rs2) ? 0xFFFFFFFF : 0x00000000
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All words equal
  TEST_RR_OP( 2,  pmseq.w, 0xffffffffffffffff, 0x0000000000000000, 0x0000000000000000 );
  TEST_RR_OP( 3,  pmseq.w, 0xffffffffffffffff, 0x0001000200010002, 0x0001000200010002 );
  TEST_RR_OP( 4,  pmseq.w, 0xffffffffffffffff, 0xaabbccddaabbccdd, 0xaabbccddaabbccdd );
  
  # One word equal
  TEST_RR_OP( 5,  pmseq.w, 0xffffffff00000000, 0x0001000200010002, 0x0001000200010003 );
  TEST_RR_OP( 6,  pmseq.w, 0x00000000ffffffff, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );
  TEST_RR_OP( 7,  pmseq.w, 0xffffffff00000000, 0x1234567812345678, 0x1234567812345679 );
  
  # No words equal
  TEST_RR_OP( 8,  pmseq.w, 0x0000000000000000, 0x0001000200010002, 0x0003000400030004 );
  TEST_RR_OP( 9,  pmseq.w, 0x0000000000000000, 0xaabbccddaabbccdd, 0x1122334411223344 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmseq.w, 0xffffffffffffffff, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_SRC2_EQ_DEST( 11, pmseq.w, 0xffffffffffffffff, 0xaabbccddaabbccdd, 0xaabbccddaabbccdd );
  TEST_RR_SRC12_EQ_DEST( 12, pmseq.w, 0xffffffffffffffff, 0x5555555555555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmseq.w, 0xffffffffffffffff, 0x1234567812345678, 0x1234567812345678 );
  TEST_RR_DEST_BYPASS( 14, 1, pmseq.w, 0x0000000000000000, 0x1234567812345678, 0x8765432187654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmseq.w, 0xffffffff00000000, 0xaabbccddaabbccdd, 0xaabbccddaabbccde );

  TEST_RR_ZEROSRC1( 16, pmseq.w, 0x0000000000000000, 0x1234567812345678 );
  TEST_RR_ZEROSRC2( 17, pmseq.w, 0x0000000000000000, 0x1234567812345678 );
  TEST_RR_ZEROSRC12( 18, pmseq.w, 0xffffffffffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

