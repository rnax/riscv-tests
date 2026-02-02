# See LICENSE for license details.

#*****************************************************************************
# mulhr.S
#-----------------------------------------------------------------------------
#
# Test mulhr instruction (high multiply with rounding).
# rd = ((sext(rs1) * sext(rs2)) >> 31 + 1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x00010000 * 0x00010000 = 0x0000000100000000, rounded high = 1
  TEST_RR_OP( 2,  mulhr, 0x00000001, 0x00010000, 0x00010000 );
  
  # Multiply with larger values: 0x00100000 * 0x00100000 = 0x0010000000000000, rounded high = 0x1000
  TEST_RR_OP( 3,  mulhr, 0x00001000, 0x00100000, 0x00100000 );
  
  # Negative multiply: 0xffffffff * 0xffffffff = 0x0000000100000001, rounded high = 1
  TEST_RR_OP( 4,  mulhr, 0x00000001, 0xffffffff, 0xffffffff );
  
  # Positive and negative: 0x00010000 * 0xffffffff = 0xffffffff00010000, rounded high = 0xffffffff
  TEST_RR_OP( 5,  mulhr, 0xffffffff, 0x00010000, 0xffffffff );
  
  # Small values: 0x00000003 * 0x00000007 = 0x00000015, rounded high = 0
  TEST_RR_OP( 6,  mulhr, 0x00000000, 0x00000003, 0x00000007 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  mulhr, 0x00000000, 0x00000000, 0x00000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, mulhr, 1, 0x00010000, 0x00010000 );
  TEST_RR_SRC2_EQ_DEST( 9, mulhr, 1, 0x00010000, 0x00010000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

