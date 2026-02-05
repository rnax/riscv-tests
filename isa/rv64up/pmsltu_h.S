# See LICENSE for license details.

#*****************************************************************************
# pmsltu_h.S
#-----------------------------------------------------------------------------
#
# Test pmsltu.h instruction (packed mask set less than unsigned halfwords).
# For each halfword: rd = (rs1 < rs2) ? 0xFFFF : 0x0000 (unsigned comparison)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All halfwords less than
  TEST_RR_OP( 2,  pmsltu.h, 0xffffffff, 0x00010002, 0x00030004 );
  TEST_RR_OP( 3,  pmsltu.h, 0xffffffff, 0x01020304, 0x05060708 );
  
  # One halfword less than
  TEST_RR_OP( 4,  pmsltu.h, 0xffff0000, 0x00010002, 0x00010003 );
  TEST_RR_OP( 5,  pmsltu.h, 0x0000ffff, 0xaabbccdd, 0xaabbccde );
  
  # No halfwords less than
  TEST_RR_OP( 6,  pmsltu.h, 0x00000000, 0x00030004, 0x00010002 );
  TEST_RR_OP( 7,  pmsltu.h, 0x00000000, 0x05060708, 0x01020304 );
  
  # High values (unsigned)
  TEST_RR_OP( 8,  pmsltu.h, 0xffffffff, 0x80008001, 0xf0f0f1f1 );
  TEST_RR_OP( 9,  pmsltu.h, 0x00000000, 0xf0f0f1f1, 0x80008001 );
  
  # Mixed high and low
  TEST_RR_OP( 10, pmsltu.h, 0xffff0000, 0x80000001, 0x80000002 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, pmsltu.h, 0x00000000, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 12, pmsltu.h, 0xffffffff, 0x00010002, 0x00030004 );
  TEST_RR_SRC12_EQ_DEST( 13, pmsltu.h, 0x00000000, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, pmsltu.h, 0xffffffff, 0x00010002, 0x00030004 );
  TEST_RR_DEST_BYPASS( 15, 1, pmsltu.h, 0x00000000, 0x00030004, 0x00010002 );
  TEST_RR_DEST_BYPASS( 16, 2, pmsltu.h, 0xffff0000, 0x00010002, 0x00010003 );

  TEST_RR_ZEROSRC1( 17, pmsltu.h, 0xffffffff, 0x00010002 );
  TEST_RR_ZEROSRC2( 18, pmsltu.h, 0x00000000, 0x00010002 );
  TEST_RR_ZEROSRC12( 19, pmsltu.h, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

