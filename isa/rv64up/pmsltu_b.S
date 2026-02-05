# See LICENSE for license details.

#*****************************************************************************
# pmsltu_b.S
#-----------------------------------------------------------------------------
#
# Test pmsltu.b instruction (packed mask set less than unsigned bytes).
# For each byte: rd = (rs1 < rs2) ? 0xFF : 0x00 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All bytes less than
  TEST_RR_OP( 2,  pmsltu.b, 0xffffffff, 0x00010203, 0x04050607 );
  TEST_RR_OP( 3,  pmsltu.b, 0xffffffff, 0x01020304, 0x05060708 );
  
  # Some bytes less than
  TEST_RR_OP( 4,  pmsltu.b, 0xff0000ff, 0x01020304, 0x01050304 );
  TEST_RR_OP( 5,  pmsltu.b, 0x00ff00ff, 0xaabbccdd, 0xaabbccde );
  
  # No bytes less than
  TEST_RR_OP( 6,  pmsltu.b, 0x00000000, 0x05060708, 0x01020304 );
  TEST_RR_OP( 7,  pmsltu.b, 0x00000000, 0x04050607, 0x01020304 );
  
  # High values (unsigned)
  TEST_RR_OP( 8,  pmsltu.b, 0xffffffff, 0x80818283, 0xf0f1f2f3 );
  TEST_RR_OP( 9,  pmsltu.b, 0x00000000, 0xf0f1f2f3, 0x80818283 );
  
  # Mixed high and low
  TEST_RR_OP( 10, pmsltu.b, 0xff0000ff, 0x80010283, 0x80050283 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmsltu.b, 0x00000000, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 12, pmsltu.b, 0xffffffff, 0x01020304, 0x05060708 );
  TEST_RR_SRC12_EQ_DEST( 13, pmsltu.b, 0x00000000, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmsltu.b, 0xffffffff, 0x01020304, 0x05060708 );
  TEST_RR_DEST_BYPASS( 15, 1, pmsltu.b, 0x00000000, 0x05060708, 0x01020304 );
  TEST_RR_DEST_BYPASS( 16, 2, pmsltu.b, 0xff0000ff, 0x01020304, 0x01050304 );

  TEST_RR_ZEROSRC1( 17, pmsltu.b, 0xffffffff, 0x01020304 );
  TEST_RR_ZEROSRC2( 18, pmsltu.b, 0x00000000, 0x01020304 );
  TEST_RR_ZEROSRC12( 19, pmsltu.b, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

