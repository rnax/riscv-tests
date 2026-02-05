# See LICENSE for license details.

#*****************************************************************************
# cls.S
#-----------------------------------------------------------------------------
#
# Test cls instruction (count leading sign bits).
# Counts leading bits matching the sign bit (MSB).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive value with many leading zeros: 0x00000001 has 31 leading sign bits
  TEST_R_OP( 2,  cls, 0x0000001f, 0x00000001 );
  
  # Positive value: 0x40000000 has 1 leading sign bit
  TEST_R_OP( 3,  cls, 0x00000001, 0x40000000 );
  
  # Negative value with many leading ones: 0xFFFFFFFF has 31 leading sign bits
  TEST_R_OP( 4,  cls, 0x0000001f, 0xffffffff );
  
  # Negative value: 0x80000000 has 0 leading sign bits (MSB differs from next)
  TEST_R_OP( 5,  cls, 0x00000000, 0x80000000 );
  
  # All zeros: 0x00000000 has 31 leading sign bits
  TEST_R_OP( 6,  cls, 0x0000001f, 0x00000000 );
  
  # All ones: 0xFFFFFFFF has 31 leading sign bits
  TEST_R_OP( 7,  cls, 0x0000001f, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_R_SRC1_EQ_DEST( 8, cls, 31, 0 );
  TEST_R_SRC1_EQ_DEST( 9, cls, 31, -1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_R_DEST_BYPASS( 10, 0, cls, 31, 0 );
  TEST_R_DEST_BYPASS( 11, 1, cls, 31, -1 );
  TEST_R_DEST_BYPASS( 12, 2, cls, 1, 0x40000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

