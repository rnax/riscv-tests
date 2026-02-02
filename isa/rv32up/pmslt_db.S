# See LICENSE for license details.

#*****************************************************************************
# pmslt_db.S
#-----------------------------------------------------------------------------
#
# Test pmslt.db instruction (packed mask signed less than double-byte).
# Compares two packed double-byte values, returns mask with all 1s for true, all 0s for false.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Less than cases (result = 0xFFFFFFFF)
  TEST_RR_OP( 2,  pmslt.db, 0xffffffff, 0x00000000, 0x00000001 );
  TEST_RR_OP( 3,  pmslt.db, 0xffffffff, 0x01020304, 0x01020305 );
  TEST_RR_OP( 4,  pmslt.db, 0xffffffff, 0x7f7f7f7f, 0x80808080 );
  
  # Not less than cases (result = 0x00000000)
  TEST_RR_OP( 5,  pmslt.db, 0x00000000, 0x00000001, 0x00000000 );
  TEST_RR_OP( 6,  pmslt.db, 0x00000000, 0x01020305, 0x01020304 );
  TEST_RR_OP( 7,  pmslt.db, 0x00000000, 0x80808080, 0x7f7f7f7f );
  
  # Equal cases (result = 0x00000000)
  TEST_RR_OP( 8,  pmslt.db, 0x00000000, 0x00000005, 0x00000005 );
  TEST_RR_OP( 9,  pmslt.db, 0x00000000, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmslt.db, 0x00000000, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 11, pmslt.db, 0x00000000, 0xabcdef00, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmslt.db, 0x00000000, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmslt.db, 0xffffffff, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 14, 1, pmslt.db, 0x00000000, 0x87654321, 0x12345678 );
  TEST_RR_DEST_BYPASS( 15, 2, pmslt.db, 0x00000000, 0xdeadbeef, 0xdeadbeef );

  TEST_RR_ZEROSRC1( 16, pmslt.db, 0xffffffff, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmslt.db, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmslt.db, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

