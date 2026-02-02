# See LICENSE for license details.

#*****************************************************************************
# pminu_dw.S
#-----------------------------------------------------------------------------
#
# Test pminu.dw instruction (packed unsigned min double-word).
# Returns the minimum of two packed double-word values (unsigned comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic min cases
  TEST_RR_OP( 2,  pminu.dw, 0x00000003, 0x00000003, 0x00000005 );
  TEST_RR_OP( 3,  pminu.dw, 0x00000001, 0x00000001, 0x00000001 );
  TEST_RR_OP( 4,  pminu.dw, 0x00000000, 0xffffffff, 0x00000000 );
  
  # Negative vs positive (unsigned)
  TEST_RR_OP( 5,  pminu.dw, 0x00000001, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 6,  pminu.dw, 0x00000002, 0xfffffffd, 0x00000002 );
  TEST_RR_OP( 7,  pminu.dw, 0x00000000, 0xffffffff, 0x00000000 );
  
  # Large unsigned values
  TEST_RR_OP( 8,  pminu.dw, 0xfffffffe, 0xffffffff, 0xfffffffe );
  TEST_RR_OP( 9,  pminu.dw, 0x80000000, 0x80000000, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pminu.dw, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 11, pminu.dw, 0x00000000, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pminu.dw, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pminu.dw, 0x00000000, 0x12345678, 0x00000000 );
  TEST_RR_DEST_BYPASS( 14, 1, pminu.dw, 0x12345678, 0x12345678, 0xffffffff );
  TEST_RR_DEST_BYPASS( 15, 2, pminu.dw, 0xdeadbeef, 0xdeadbeef, 0x00000000 );

  TEST_RR_ZEROSRC1( 16, pminu.dw, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pminu.dw, 0x00000000, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pminu.dw, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

