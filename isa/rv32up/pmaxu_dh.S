# See LICENSE for license details.

#*****************************************************************************
# pmaxu_dh.S
#-----------------------------------------------------------------------------
#
# Test pmaxu.dh instruction (packed unsigned max double-halfword).
# Returns the maximum of two packed double-halfword values (unsigned comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic max cases
  TEST_RR_OP( 2,  pmaxu.dh, 0x00000005, 0x00000003, 0x00000005 );
  TEST_RR_OP( 3,  pmaxu.dh, 0x00010002, 0x00010002, 0x00010002 );
  TEST_RR_OP( 4,  pmaxu.dh, 0xffffffff, 0xffffffff, 0x00000000 );
  
  # Negative vs positive (unsigned)
  TEST_RR_OP( 5,  pmaxu.dh, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_RR_OP( 6,  pmaxu.dh, 0xfffefffd, 0xfffefffd, 0x00010002 );
  TEST_RR_OP( 7,  pmaxu.dh, 0xffffffff, 0xffffffff, 0x00000000 );
  
  # Large unsigned values
  TEST_RR_OP( 8,  pmaxu.dh, 0xffffffff, 0xffffffff, 0xfffffffe );
  TEST_RR_OP( 9,  pmaxu.dh, 0xffffffff, 0x80008000, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, pmaxu.dh, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 11, pmaxu.dh, 0xabcdef00, 0x00000000, 0xabcdef00 );
  TEST_RR_SRC12_EQ_DEST( 12, pmaxu.dh, 0x55555555, 0x55555555 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, pmaxu.dh, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_DEST_BYPASS( 14, 1, pmaxu.dh, 0xffffffff, 0x12345678, 0xffffffff );
  TEST_RR_DEST_BYPASS( 15, 2, pmaxu.dh, 0xdeadbeef, 0xdeadbeef, 0x00000000 );

  TEST_RR_ZEROSRC1( 16, pmaxu.dh, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC2( 17, pmaxu.dh, 0x12345678, 0x12345678 );
  TEST_RR_ZEROSRC12( 18, pmaxu.dh, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

