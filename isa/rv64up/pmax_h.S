# See LICENSE for license details.

#*****************************************************************************
# pmax_h.S
#-----------------------------------------------------------------------------
#
# Test pmax.h instruction (packed signed maximum halfwords).
# For each halfword: rd = (rs1 > rs2) ? rs1 : rs2 (signed comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic max cases
  TEST_RR_OP( 2,  pmax.h, 0x00030004, 0x00010002, 0x00030004 );
  TEST_RR_OP( 3,  pmax.h, 0x00030004, 0x00030004, 0x00010002 );
  TEST_RR_OP( 4,  pmax.h, 0x00010002, 0x00010002, 0x00010002 );
  
  # Mixed values
  TEST_RR_OP( 5,  pmax.h, 0x00010005, 0x00010005, 0x00010002 );
  TEST_RR_OP( 6,  pmax.h, 0xaabbccde, 0xaabbccdd, 0xaabbccde );
  
  # Negative vs positive
  TEST_RR_OP( 7,  pmax.h, 0x00010002, 0x80008001, 0x00010002 );
  TEST_RR_OP( 8,  pmax.h, 0x00010002, 0xfffefffd, 0x00010002 );
  
  # Negative vs negative
  TEST_RR_OP( 9,  pmax.h, 0x80008002, 0x80008001, 0x80008002 );
  TEST_RR_OP( 10, pmax.h, 0xffffffff, 0xfffefffd, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmax.h, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pmax.h, 0xabcdef00, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pmax.h, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmax.h, 0x00030004, 0x00010002, 0x00030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pmax.h, 0x00030004, 0x00030004, 0x00010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pmax.h, 0x00010002, 0x80008001, 0x00010002 );

  TEST_RR_ZEROSRC1( 17, pmax.h, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC2( 18, pmax.h, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC12( 19, pmax.h, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

