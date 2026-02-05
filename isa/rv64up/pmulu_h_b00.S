# See LICENSE for license details.

#*****************************************************************************
# pmulu_h_b00.S
#-----------------------------------------------------------------------------
#
# Test pmulu.h.b00 instruction (packed unsigned multiply bottom-bottom).
# rd[31:16] = zext(rs1[15:0]) * zext(rs2[15:0])
# rd[15:0] = zext(rs1[15:0]) * zext(rs2[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x0015)
  TEST_RR_OP( 2,  pmulu.h.b00, 0x00150015, 0x00000003, 0x00000007 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x1388)
  TEST_RR_OP( 3,  pmulu.h.b00, 0x13881388, 0x00000064, 0x00000032 );
  
  # Unsigned multiply: 0xffff * 0xffff = 0xfffe0001
  TEST_RR_OP( 4,  pmulu.h.b00, 0xfffe0001, 0xffffffff, 0xffffffff );
  
  # Halfword selection (lower 16 bits): 0x0005 * 0x000a = 50 (0x0032)
  TEST_RR_OP( 5,  pmulu.h.b00, 0x00320032, 0x12340005, 0x5678000a );
  
  # Unsigned multiply: 0xffff * 0x0001 = 0xffff
  TEST_RR_OP( 6,  pmulu.h.b00, 0x0000ffff, 0xffffffff, 0x00010000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulu.h.b00, 0x00000000, 0x00000000, 0x00000064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulu.h.b00, 0x00150015, 3, 7 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulu.h.b00, 0x00230023, 5, 7 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

