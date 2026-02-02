# See LICENSE for license details.

#*****************************************************************************
# pmin_db.S
#-----------------------------------------------------------------------------
#
# Test pmin.db instruction (packed signed min double-byte).
# Returns the minimum of two packed double-byte values (signed comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pmin.db, 0x00000003, 0x00000003, 0x00000005 );
  TEST_RR_OP( 3,  pmin.db, 0x01020304, 0x01020304, 0x01020304 );
  TEST_RR_OP( 4,  pmin.db, 0x00000000, 0x7f7f7f7f, 0x00000000 );
  
  # Negative vs positive
  TEST_RR_OP( 5,  pmin.db, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 6,  pmin.db, 0xfefdfcfb, 0xfefdfcfb, 0x01020304 );
  TEST_RR_OP( 7,  pmin.db, 0xffffffff, 0xffffffff, 0x00000000 );
  
  # Negative vs negative
  TEST_RR_OP( 8,  pmin.db, 0xfffffffe, 0xffffffff, 0xfffffffe );
  TEST_RR_OP( 9,  pmin.db, 0x7f7f7f7f, 0x80808080, 0x7f7f7f7f );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmin.db, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 11, pmin.db, 0x00000000, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmin.db, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmin.db, 0x00000000, 0x12345678, 0x00000000 );
  TEST_RR_DEST_BYPASS( 14, 1, pmin.db, 0x12345678, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmin.db, 0xdeadbeef, 0xdeadbeef, 0x00000000 );

  TEST_RR_ZEROSRC1( 16, pmin.db, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmin.db, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmin.db, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

