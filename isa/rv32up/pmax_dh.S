# See LICENSE for license details.

#*****************************************************************************
# pmax_dh.S
#-----------------------------------------------------------------------------
#
# Test pmax.dh instruction (packed signed max double-halfword).
# Returns the maximum of two packed double-halfword values (signed comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic max cases
  TEST_RR_OP( 2,  pmax.dh, 0x00000005, 0x00000003, 0x00000005 );
  TEST_RR_OP( 3,  pmax.dh, 0x00010002, 0x00010002, 0x00010002 );
  TEST_RR_OP( 4,  pmax.dh, 0x7fff7fff, 0x7fff7fff, 0x00000000 );
  
  # Negative vs positive
  TEST_RR_OP( 5,  pmax.dh, 0x00000001, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 6,  pmax.dh, 0x00010002, 0xfffefffd, 0x00010002 );
  TEST_RR_OP( 7,  pmax.dh, 0x00000000, 0xffffffff, 0x00000000 );
  
  # Negative vs negative
  TEST_RR_OP( 8,  pmax.dh, 0xffffffff, 0xffffffff, 0xfffffffe );
  TEST_RR_OP( 9,  pmax.dh, 0x80008000, 0x80008000, 0x7fff7fff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmax.dh, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 11, pmax.dh, 0xabcdef00, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmax.dh, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmax.dh, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_DEST_BYPASS( 14, 1, pmax.dh, 0x87654321, 0x12345678, 0x87654321 );
  TEST_RR_DEST_BYPASS( 15, 2, pmax.dh, 0xdeadbeef, 0xdeadbeef, 0x00000000 );

  TEST_RR_ZEROSRC1( 16, pmax.dh, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmax.dh, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmax.dh, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

