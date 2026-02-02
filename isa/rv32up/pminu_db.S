# See LICENSE for license details.

#*****************************************************************************
# pminu_db.S
#-----------------------------------------------------------------------------
#
# Test pminu.db instruction (packed unsigned min double-byte).
# Returns the minimum of two packed double-byte values (unsigned comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pminu.db, 0x00000003, 0x00000003, 0x00000005 );
  TEST_RR_OP( 3,  pminu.db, 0x01020304, 0x01020304, 0x01020304 );
  TEST_RR_OP( 4,  pminu.db, 0x00000000, 0xffffffff, 0x00000000 );
  
  # Negative vs positive (unsigned)
  TEST_RR_OP( 5,  pminu.db, 0x00000001, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 6,  pminu.db, 0x01020304, 0xfefdfcfb, 0x01020304 );
  TEST_RR_OP( 7,  pminu.db, 0x00000000, 0xffffffff, 0x00000000 );
  
  # Large unsigned values
  TEST_RR_OP( 8,  pminu.db, 0xfffffffe, 0xffffffff, 0xfffffffe );
  TEST_RR_OP( 9,  pminu.db, 0x80808080, 0x80808080, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pminu.db, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 11, pminu.db, 0x00000000, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pminu.db, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pminu.db, 0x00000000, 0x12345678, 0x00000000 );
  TEST_RR_DEST_BYPASS( 14, 1, pminu.db, 0x12345678, 0x12345678, 0xffffffff );
  TEST_RR_DEST_BYPASS( 15, 2, pminu.db, 0xdeadbeef, 0xdeadbeef, 0x00000000 );

  TEST_RR_ZEROSRC1( 16, pminu.db, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pminu.db, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pminu.db, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

