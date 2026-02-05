# See LICENSE for license details.

#*****************************************************************************
# pmulu_h_b11.S
#-----------------------------------------------------------------------------
#
# Test pmulu.h.b11 instruction (packed unsigned multiply top-top).
# rd[31:16] = zext(rs1[31:16]) * zext(rs2[31:16])
# rd[15:0] = zext(rs1[31:16]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x0015)
  TEST_RR_OP( 2,  pmulu.h.b11, 0x00150015, 0x00030000, 0x00070000 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x1388)
  TEST_RR_OP( 3,  pmulu.h.b11, 0x13881388, 0x00640000, 0x00320000 );
  
  # Unsigned multiply: 0xffff * 0xffff = 0xfffe0001
  TEST_RR_OP( 4,  pmulu.h.b11, 0xfffe0001, 0xffff0000, 0xffff0000 );
  
  # Halfword selection (top 16 bits): 0x1234 * 0x5678 = 0x5b3a4c
  TEST_RR_OP( 5,  pmulu.h.b11, 0x5b3a5b3a, 0x12340000, 0x56780000 );
  
  # Unsigned multiply: 0xffff * 0x0001 = 0xffff
  TEST_RR_OP( 6,  pmulu.h.b11, 0x0000ffff, 0xffff0000, 0x00010000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulu.h.b11, 0x00000000, 0x00000000, 0x00640000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulu.h.b11, 0x00150015, 0x00030000, 0x00070000 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulu.h.b11, 0x00230023, 0x00050000, 0x00070000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

