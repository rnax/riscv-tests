# See LICENSE for license details.

#*****************************************************************************
# pmaxu_b.S
#-----------------------------------------------------------------------------
#
# Test pmaxu.b instruction (packed unsigned maximum bytes).
# For each byte: rd = (rs1 > rs2) ? rs1 : rs2 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic max cases
  TEST_RR_OP( 2,  pmaxu.b, 0x05060708, 0x01020304, 0x05060708 );
  TEST_RR_OP( 3,  pmaxu.b, 0x05060708, 0x05060708, 0x01020304 );
  TEST_RR_OP( 4,  pmaxu.b, 0x01020304, 0x01020304, 0x01020304 );
  
  # Mixed values
  TEST_RR_OP( 5,  pmaxu.b, 0x01050304, 0x01050304, 0x01020308 );
  TEST_RR_OP( 6,  pmaxu.b, 0xaabbccde, 0xaabbccdd, 0xaabbccde );
  
  # High values (unsigned)
  TEST_RR_OP( 7,  pmaxu.b, 0xf0f1f2f3, 0x80818283, 0xf0f1f2f3 );
  TEST_RR_OP( 8,  pmaxu.b, 0xf0f1f2f3, 0xf0f1f2f3, 0x80818283 );
  
  # All high values
  TEST_RR_OP( 9,  pmaxu.b, 0x80818284, 0x80818283, 0x80818284 );
  TEST_RR_OP( 10, pmaxu.b, 0xffffffff, 0xfefdfcfb, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmaxu.b, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pmaxu.b, 0xabcdef00, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pmaxu.b, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmaxu.b, 0x05060708, 0x01020304, 0x05060708 );
  TEST_RR_DEST_BYPASS( 15, 1, pmaxu.b, 0x05060708, 0x05060708, 0x01020304 );
  TEST_RR_DEST_BYPASS( 16, 2, pmaxu.b, 0xf0f1f2f3, 0x80818283, 0xf0f1f2f3 );

  TEST_RR_ZEROSRC1( 17, pmaxu.b, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC2( 18, pmaxu.b, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC12( 19, pmaxu.b, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

