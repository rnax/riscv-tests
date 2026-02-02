# See LICENSE for license details.

#*****************************************************************************
# pmseq_dh.S
#-----------------------------------------------------------------------------
#
# Test pmseq.dh instruction (packed mask equal double-halfword).
# Compares two packed double-halfword values, returns mask with all 1s for true, all 0s for false.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Equal cases (result = 0xFFFFFFFF)
  TEST_RR_OP( 2,  pmseq.dh, 0xffffffff, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  pmseq.dh, 0xffffffff, 0x00010002, 0x00010002 );
  TEST_RR_OP( 4,  pmseq.dh, 0xffffffff, 0x7fff7fff, 0x7fff7fff );
  
  # Not equal cases (result = 0x00000000)
  TEST_RR_OP( 5,  pmseq.dh, 0x00000000, 0x00000000, 0x00000001 );
  TEST_RR_OP( 6,  pmseq.dh, 0x00000000, 0x00010002, 0x00010003 );
  TEST_RR_OP( 7,  pmseq.dh, 0x00000000, 0x7fff7fff, 0x80008000 );
  
  # Negative numbers equal
  TEST_RR_OP( 8,  pmseq.dh, 0xffffffff, 0xffffffff, 0xffffffff );
  TEST_RR_OP( 9,  pmseq.dh, 0xffffffff, 0x80008000, 0x80008000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmseq.dh, 0xffffffff, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 11, pmseq.dh, 0xffffffff, 0xabcdef00, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmseq.dh, 0xffffffff, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmseq.dh, 0xffffffff, 0x12345678, 0x12345678 );
  TEST_RR_DEST_BYPASS( 14, 1, pmseq.dh, 0x00000000, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmseq.dh, 0xffffffff, 0xdeadbeef, 0xdeadbeef );

  TEST_RR_ZEROSRC1( 16, pmseq.dh, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmseq.dh, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmseq.dh, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

