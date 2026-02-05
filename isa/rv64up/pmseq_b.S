# See LICENSE for license details.

#*****************************************************************************
# pmseq_b.S
#-----------------------------------------------------------------------------
#
# Test pmseq.b instruction (packed mask set equal bytes).
# For each byte: rd = (rs1 == rs2) ? 0xFF : 0x00
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All bytes equal
  TEST_RR_OP( 2,  pmseq.b, 0xffffffff, 0x00000000, 0x00000000 );
  TEST_RR_OP( 3,  pmseq.b, 0xffffffff, 0x01020304, 0x01020304 );
  TEST_RR_OP( 4,  pmseq.b, 0xffffffff, 0xaabbccdd, 0xaabbccdd );
  
  # Some bytes equal
  TEST_RR_OP( 5,  pmseq.b, 0xff0000ff, 0x01020304, 0x01020305 );
  TEST_RR_OP( 6,  pmseq.b, 0x00ff00ff, 0xaabbccdd, 0xaabbccde );
  TEST_RR_OP( 7,  pmseq.b, 0xff00ff00, 0x12345678, 0x12345679 );
  
  # No bytes equal
  TEST_RR_OP( 8,  pmseq.b, 0x00000000, 0x01020304, 0x05060708 );
  TEST_RR_OP( 9,  pmseq.b, 0x00000000, 0xaabbccdd, 0x11223344 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmseq.b, 0xffffffff, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 11, pmseq.b, 0xffffffff, 0xaabbccdd, 0xaabbccdd );
  TEST_RR_SRC12_EQ_DEST( 12, pmseq.b, 0xffffffff, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmseq.b, 0xffffffff, 0x12345678, 0x12345678 );
  TEST_RR_DEST_BYPASS( 14, 1, pmseq.b, 0x00000000, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmseq.b, 0xff0000ff, 0xaabbccdd, 0xaabbccde );

  TEST_RR_ZEROSRC1( 16, pmseq.b, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmseq.b, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmseq.b, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

