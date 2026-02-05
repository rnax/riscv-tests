# See LICENSE for license details.

#*****************************************************************************
# pminu_h.S
#-----------------------------------------------------------------------------
#
# Test pminu.h instruction (packed unsigned minimum halfwords).
# For each halfword: rd = (rs1 < rs2) ? rs1 : rs2 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pminu.h, 0x00010002, 0x00010002, 0x00030004 );
  TEST_RR_OP( 3,  pminu.h, 0x00010002, 0x00030004, 0x00010002 );
  TEST_RR_OP( 4,  pminu.h, 0x00010002, 0x00010002, 0x00010002 );
  
  # Mixed values
  TEST_RR_OP( 5,  pminu.h, 0x00010002, 0x00010005, 0x00010002 );
  TEST_RR_OP( 6,  pminu.h, 0xaabbccdd, 0xaabbccdd, 0xaabbccde );
  
  # High values (unsigned)
  TEST_RR_OP( 7,  pminu.h, 0x80008001, 0x80008001, 0xf0f0f1f1 );
  TEST_RR_OP( 8,  pminu.h, 0x80008001, 0xf0f0f1f1, 0x80008001 );
  
  # All high values
  TEST_RR_OP( 9,  pminu.h, 0x80008001, 0x80008001, 0x80008002 );
  TEST_RR_OP( 10, pminu.h, 0xfffefffd, 0xfffefffd, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pminu.h, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 12, pminu.h, 0x00000000, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 13, pminu.h, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pminu.h, 0x00010002, 0x00010002, 0x00030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pminu.h, 0x00010002, 0x00030004, 0x00010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pminu.h, 0x80008001, 0x80008001, 0xf0f0f1f1 );

  TEST_RR_ZEROSRC1( 17, pminu.h, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 18, pminu.h, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 19, pminu.h, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

