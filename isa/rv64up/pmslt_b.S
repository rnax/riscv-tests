# See LICENSE for license details.

#*****************************************************************************
# pmslt_b.S
#-----------------------------------------------------------------------------
#
# Test pmslt.b instruction (packed mask set less than signed bytes).
# For each byte: rd = (rs1 < rs2) ? 0xFF : 0x00 (signed comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All bytes less than
  TEST_RR_OP( 2,  pmslt.b, 0xffffffff, 0x00010203, 0x04050607 );
  TEST_RR_OP( 3,  pmslt.b, 0xffffffff, 0x01020304, 0x05060708 );
  
  # Some bytes less than
  TEST_RR_OP( 4,  pmslt.b, 0xff0000ff, 0x01020304, 0x01050304 );
  TEST_RR_OP( 5,  pmslt.b, 0x00ff00ff, 0xaabbccdd, 0xaabbccde );
  
  # No bytes less than
  TEST_RR_OP( 6,  pmslt.b, 0x00000000, 0x05060708, 0x01020304 );
  TEST_RR_OP( 7,  pmslt.b, 0x00000000, 0x04050607, 0x01020304 );
  
  # Negative vs positive
  TEST_RR_OP( 8,  pmslt.b, 0xffffffff, 0x80818283, 0x01020304 );
  TEST_RR_OP( 9,  pmslt.b, 0xffffffff, 0xfefdfcfb, 0x00010203 );
  
  # Negative vs negative
  TEST_RR_OP( 10, pmslt.b, 0xff0000ff, 0x80818283, 0x80818284 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmslt.b, 0x00000000, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 12, pmslt.b, 0xffffffff, 0x01020304, 0x05060708 );
  TEST_RR_SRC12_EQ_DEST( 13, pmslt.b, 0x00000000, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmslt.b, 0xffffffff, 0x01020304, 0x05060708 );
  TEST_RR_DEST_BYPASS( 15, 1, pmslt.b, 0x00000000, 0x05060708, 0x01020304 );
  TEST_RR_DEST_BYPASS( 16, 2, pmslt.b, 0xff0000ff, 0x01020304, 0x01050304 );

  TEST_RR_ZEROSRC1( 17, pmslt.b, 0xffffffff, 0x01020304 );
  TEST_RR_ZEROSRC2( 18, pmslt.b, 0x00000000, 0x01020304 );
  TEST_RR_ZEROSRC12( 19, pmslt.b, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

