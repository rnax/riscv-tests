# See LICENSE for license details.

#*****************************************************************************
# pmulh_h_b0.S
#-----------------------------------------------------------------------------
#
# Test pmulh.h.b0 instruction (packed multiply high halfword bottom).
# rd = (sext(rs1[15:0]) * sext(rs2[15:0])) >> 16
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x0100 * 0x0100 = 0x10000, high = 1
  TEST_RR_OP( 2,  pmulh.h.b0, 0x00000001, 0x01000100, 0x01000100 );
  
  # Multiply with larger values: 0x1000 * 0x1000 = 0x1000000, high = 0x100
  TEST_RR_OP( 3,  pmulh.h.b0, 0x00000100, 0x10001000, 0x10001000 );
  
  # Negative multiply: 0xffff * 0x0001 = 0xffffffff, high = 0xffffffff
  TEST_RR_OP( 4,  pmulh.h.b0, 0xffffffff, 0xffffffff, 0x00010001 );
  
  # Mixed signs: 0x0100 * 0xffff = 0xffffff00, high = 0xffff
  TEST_RR_OP( 5,  pmulh.h.b0, 0xffffffff, 0x01000100, 0xffffffff );
  
  # Negative result: 0xffff * 0xffff = 0x00010001, high = 0x0000
  TEST_RR_OP( 6,  pmulh.h.b0, 0x00000000, 0xffffffff, 0xffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulh.h.b0, 0x00000000, 0x00000000, 0x00640064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulh.h.b0, 0x00000001, 0x01000100, 0x01000100 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulh.h.b0, 0x00000001, 0x01000100, 0x01000100 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

