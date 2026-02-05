# See LICENSE for license details.

#*****************************************************************************
# pmin_b.S
#-----------------------------------------------------------------------------
#
# Test pmin.b instruction (packed signed minimum bytes).
# For each byte: rd = (rs1 < rs2) ? rs1 : rs2 (signed comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pmin.b, 0x01020304, 0x01020304, 0x05060708 );
  TEST_RR_OP( 3,  pmin.b, 0x01020304, 0x05060708, 0x01020304 );
  TEST_RR_OP( 4,  pmin.b, 0x01020304, 0x01020304, 0x01020304 );
  
  # Mixed values
  TEST_RR_OP( 5,  pmin.b, 0x01020304, 0x01050304, 0x01020308 );
  TEST_RR_OP( 6,  pmin.b, 0xaabbccdd, 0xaabbccdd, 0xaabbccde );
  
  # Negative vs positive
  TEST_RR_OP( 7,  pmin.b, 0x80818283, 0x80818283, 0x01020304 );
  TEST_RR_OP( 8,  pmin.b, 0xfefdfcfb, 0xfefdfcfb, 0x00010203 );
  
  # Negative vs negative
  TEST_RR_OP( 9,  pmin.b, 0x80818283, 0x80818283, 0x80818284 );
  TEST_RR_OP( 10, pmin.b, 0xfefdfcfb, 0xfefdfcfb, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmin.b, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pmin.b, 0x00000000, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pmin.b, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmin.b, 0x01020304, 0x01020304, 0x05060708 );
  TEST_RR_DEST_BYPASS( 15, 1, pmin.b, 0x01020304, 0x05060708, 0x01020304 );
  TEST_RR_DEST_BYPASS( 16, 2, pmin.b, 0x80818283, 0x80818283, 0x01020304 );

  TEST_RR_ZEROSRC1( 17, pmin.b, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 18, pmin.b, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 19, pmin.b, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

