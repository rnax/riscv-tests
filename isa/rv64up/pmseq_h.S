# See LICENSE for license details.

#*****************************************************************************
# pmseq_h.S
#-----------------------------------------------------------------------------
#
# Test pmseq.h instruction (packed mask set equal halfwords).
# For each halfword: rd = (rs1 == rs2) ? 0xFFFF : 0x0000
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All halfwords equal
  TEST_RR_OP( 2,  pmseq.h, 0xffffffff, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  pmseq.h, 0xffffffff, 0x00010002, 0x00010002 );
  TEST_RR_OP( 4,  pmseq.h, 0xffffffff, 0xaabbccdd, 0xaabbccdd );
  
  # One halfword equal
  TEST_RR_OP( 5,  pmseq.h, 0xffff0000, 0x00010002, 0x00010003 );
  TEST_RR_OP( 6,  pmseq.h, 0x0000ffff, 0xaabbccdd, 0xaabbccde );
  TEST_RR_OP( 7,  pmseq.h, 0xffff0000, 0x12345678, 0x12345679 );
  
  # No halfwords equal
  TEST_RR_OP( 8,  pmseq.h, 0x00000000, 0x00010002, 0x00030004 );
  TEST_RR_OP( 9,  pmseq.h, 0x00000000, 0xaabbccdd, 0x11223344 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmseq.h, 0xffffffff, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 11, pmseq.h, 0xffffffff, 0xaabbccdd, 0xaabbccdd );
  TEST_RR_SRC12_EQ_DEST( 12, pmseq.h, 0xffffffff, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmseq.h, 0xffffffff, 0x12345678, 0x12345678 );
  TEST_RR_DEST_BYPASS( 14, 1, pmseq.h, 0x00000000, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmseq.h, 0xffff0000, 0xaabbccdd, 0xaabbccde );

  TEST_RR_ZEROSRC1( 16, pmseq.h, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmseq.h, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmseq.h, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

