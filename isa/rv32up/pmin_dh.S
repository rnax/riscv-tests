# See LICENSE for license details.

#*****************************************************************************
# pmin_dh.S
#-----------------------------------------------------------------------------
#
# Test pmin.dh instruction (packed signed min double-halfword).
# Returns the minimum of two packed double-halfword values (signed comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pmin.dh, 0x00000003, 0x00000003, 0x00000005 );
  TEST_RR_OP( 3,  pmin.dh, 0x00010002, 0x00010002, 0x00010002 );
  TEST_RR_OP( 4,  pmin.dh, 0x00000000, 0x7fff7fff, 0x00000000 );
  
  # Negative vs positive
  TEST_RR_OP( 5,  pmin.dh, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 6,  pmin.dh, 0xfffefffd, 0xfffefffd, 0x00010002 );
  TEST_RR_OP( 7,  pmin.dh, 0xffffffff, 0xffffffff, 0x00000000 );
  
  # Negative vs negative
  TEST_RR_OP( 8,  pmin.dh, 0xfffffffe, 0xffffffff, 0xfffffffe );
  TEST_RR_OP( 9,  pmin.dh, 0x7fff7fff, 0x80008000, 0x7fff7fff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmin.dh, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 11, pmin.dh, 0x00000000, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmin.dh, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmin.dh, 0x00000000, 0x12345678, 0x00000000 );
  TEST_RR_DEST_BYPASS( 14, 1, pmin.dh, 0x12345678, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmin.dh, 0xdeadbeef, 0xdeadbeef, 0x00000000 );

  TEST_RR_ZEROSRC1( 16, pmin.dh, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmin.dh, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmin.dh, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

