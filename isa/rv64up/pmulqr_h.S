# See LICENSE for license details.

#*****************************************************************************
# pmulqr_h.S
#-----------------------------------------------------------------------------
#
# Test pmulqr.h instruction (packed Q-format multiply with rounding halfword).
# rd[31:16] = ((sext(rs1[31:16]) * sext(rs2[31:16])) >> 14) + 1) >> 1
# rd[15:0] = ((sext(rs1[15:0]) * sext(rs2[15:0])) >> 14) + 1) >> 1
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x0100 * 0x0100 = 0x10000, Q-rounded = 2
  TEST_RR_OP( 2,  pmulqr.h, 0x00020002, 0x01000100, 0x01000100 );
  
  # Multiply with larger values: 0x1000 * 0x1000 = 0x1000000, Q-rounded = 0x200
  TEST_RR_OP( 3,  pmulqr.h, 0x02000200, 0x10001000, 0x10001000 );
  
  # Negative multiply: 0xffff * 0x0001 = 0xffffffff, Q-rounded = 0xffffffff
  TEST_RR_OP( 4,  pmulqr.h, 0xffffffff, 0xffffffff, 0x00010001 );
  
  # Mixed signs: 0x0100 * 0xffff = 0xffffff00, Q-rounded = 0xffffffff
  TEST_RR_OP( 5,  pmulqr.h, 0xffffffff, 0x01000100, 0xffffffff );
  
  # Negative result: 0xffff * 0xffff = 0x00010001, Q-rounded = 0x00020002
  TEST_RR_OP( 6,  pmulqr.h, 0x00020002, 0xffffffff, 0xffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulqr.h, 0x00000000, 0x00000000, 0x00640064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulqr.h, 0x00020002, 0x01000100, 0x01000100 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulqr.h, 0x00020002, 0x01000100, 0x01000100 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

