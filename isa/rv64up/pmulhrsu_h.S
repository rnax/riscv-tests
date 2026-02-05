# See LICENSE for license details.

#*****************************************************************************
# pmulhrsu_h.S
#-----------------------------------------------------------------------------
#
# Test pmulhrsu.h instruction (packed multiply high with rounding signed*unsigned).
# rd[31:16] = ((sext(rs1[31:16]) * zext(rs2[31:16])) >> 15) + 1) >> 1
# rd[15:0] = ((sext(rs1[15:0]) * zext(rs2[15:0])) >> 15) + 1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x0100 * 0x0100 = 0x10000, rounded high = 1
  TEST_RR_OP( 2,  pmulhrsu.h, 0x00010001, 0x01000100, 0x01000100 );
  
  # Multiply with larger values: 0x1000 * 0x1000 = 0x1000000, rounded high = 0x100
  TEST_RR_OP( 3,  pmulhrsu.h, 0x01000100, 0x10001000, 0x10001000 );
  
  # Signed * Unsigned: 0xffff * 0x0001 = 0xffffffff, rounded high = 0xffffffff
  TEST_RR_OP( 4,  pmulhrsu.h, 0xffffffff, 0xffffffff, 0x00010001 );
  
  # Mixed: 0x0100 * 0xffff = 0x00ff0100, rounded high = 0x00ff
  TEST_RR_OP( 5,  pmulhrsu.h, 0x00ff00ff, 0x01000100, 0xffffffff );
  
  # Negative signed: 0xffff * 0xffff = 0xfffe0001, rounded high = 0xffff
  TEST_RR_OP( 6,  pmulhrsu.h, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulhrsu.h, 0x00000000, 0x00000000, 0x00640064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulhrsu.h, 0x00010001, 0x01000100, 0x01000100 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulhrsu.h, 0x00010001, 0x01000100, 0x01000100 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

