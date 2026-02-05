# See LICENSE for license details.

#*****************************************************************************
# absw.S
#-----------------------------------------------------------------------------
#
# Test absw instruction (absolute value word - 32-bit).
# rd = |rs1[31:0]| sign-extended to 64-bit
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Positive value: |5| = 5
  TEST_R_OP( 2,  absw, 0x0000000000000005, 0x0000000000000005 );
  
  # Negative value: |-5| = 5
  TEST_R_OP( 3,  absw, 0x0000000000000005, 0xfffffffffffffffb );
  
  # Zero: |0| = 0
  TEST_R_OP( 4,  absw, 0x0000000000000000, 0x0000000000000000 );
  
  # Min int32 (special case): |0x80000000| = 0x80000000 (saturates)
  TEST_R_OP( 5,  absw, 0xffffffff80000000, 0xffffffff80000000 );
  
  # Max int32: |0x7FFFFFFF| = 0x7FFFFFFF
  TEST_R_OP( 6,  absw, 0x000000007fffffff, 0x000000007fffffff );
  
  # Large negative: |-1000| = 1000
  TEST_R_OP( 7,  absw, 0x00000000000003e8, 0xfffffffffffffc18 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_R_SRC1_EQ_DEST( 8, absw, 0x0000000000000005, 0x0000000000000005 );
  TEST_R_SRC1_EQ_DEST( 9, absw, 0x000000000000000a, 0xfffffffffffffff6 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

