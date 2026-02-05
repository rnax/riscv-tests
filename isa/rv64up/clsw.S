# See LICENSE for license details.

#*****************************************************************************
# clsw.S
#-----------------------------------------------------------------------------
#
# Test clsw instruction (count leading sign bits word - 32-bit).
# Counts leading bits matching sign bit in lower 32 bits
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # All zeros in lower 32 bits: 31 leading sign bits
  TEST_R_OP( 2,  clsw, 0x000000000000001f, 0x0000000000000000 );
  
  # All ones in lower 32 bits: 31 leading sign bits
  TEST_R_OP( 3,  clsw, 0x000000000000001f, 0xffffffffffffffff );
  
  # 0x7FFFFFFF (max int32): 0 leading sign bits (MSB is 0, next is 1)
  TEST_R_OP( 4,  clsw, 0x0000000000000000, 0x000000007fffffff );
  
  # 0x80000000 (min int32): 0 leading sign bits (MSB is 1, next is 0)
  TEST_R_OP( 5,  clsw, 0x0000000000000000, 0xffffffff80000000 );
  
  # 0x00000001: 30 leading sign bits (0 followed by 30 zeros)
  TEST_R_OP( 6,  clsw, 0x000000000000001e, 0x0000000000000001 );
  
  # 0xFFFFFFFE: 30 leading sign bits (1 followed by 30 ones)
  TEST_R_OP( 7,  clsw, 0x000000000000001e, 0xfffffffffffffffe );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_R_SRC1_EQ_DEST( 8, clsw, 0x000000000000001f, 0x0000000000000000 );
  TEST_R_SRC1_EQ_DEST( 9, clsw, 0x0000000000000000, 0x000000007fffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

