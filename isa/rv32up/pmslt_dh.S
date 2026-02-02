# See LICENSE for license details.

#*****************************************************************************
# pmslt_dh.S
#-----------------------------------------------------------------------------
#
# Test pmslt.dh instruction (packed mask signed less than double-halfword).
# Compares two packed double-halfword values, returns mask with all 1s for true, all 0s for false.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Less than cases (result = 0xFFFFFFFF)
  TEST_RR_OP( 2,  pmslt.dh, 0xffffffff, 0x00000000, 0x00000001 );
  TEST_RR_OP( 3,  pmslt.dh, 0xffffffff, 0x00010002, 0x00010003 );
  TEST_RR_OP( 4,  pmslt.dh, 0xffffffff, 0x7fff7fff, 0x80008000 );
  
  # Not less than cases (result = 0x00000000)
  TEST_RR_OP( 5,  pmslt.dh, 0x00000000, 0x00000001, 0x00000000 );
  TEST_RR_OP( 6,  pmslt.dh, 0x00000000, 0x00010003, 0x00010002 );
  TEST_RR_OP( 7,  pmslt.dh, 0x00000000, 0x80008000, 0x7fff7fff );
  
  # Equal cases (result = 0x00000000)
  TEST_RR_OP( 8,  pmslt.dh, 0x00000000, 0x00000005, 0x00000005 );
  TEST_RR_OP( 9,  pmslt.dh, 0x00000000, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmslt.dh, 0x00000000, 0x12345678, 0x12345678 );
  TEST_RR_SRC2_EQ_DEST( 11, pmslt.dh, 0x00000000, 0xabcdef00, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmslt.dh, 0x00000000, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmslt.dh, 0xffffffff, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 14, 1, pmslt.dh, 0x00000000, 0x87654321, 0x12345678 );
  TEST_RR_DEST_BYPASS( 15, 2, pmslt.dh, 0x00000000, 0xdeadbeef, 0xdeadbeef );

  TEST_RR_ZEROSRC1( 16, pmslt.dh, 0xffffffff, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmslt.dh, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmslt.dh, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

