# See LICENSE for license details.

#*****************************************************************************
# pmulu_w_h01.S
#-----------------------------------------------------------------------------
#
# Test pmulu.w.h01 instruction (packed multiply unsigned word bottom-top).
# rd[63:32] = zext(rs1[15:0]) * zext(rs2[31:16])
# rd[31:0] = zext(rs1[15:0]) * zext(rs2[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 3 * 7 = 21 (0x00000015)
  TEST_RR_OP( 2,  pmulu.w.h01, 0x0000001500000015, 0x0000000300000003, 0x0007000700070007 );
  
  # Multiply with larger values: 100 * 50 = 5000 (0x00001388)
  TEST_RR_OP( 3,  pmulu.w.h01, 0x0000138800001388, 0x0000006400000064, 0x0032003200320032 );
  
  # Unsigned multiply: 0xffff * 0x0001 = 0xffff
  TEST_RR_OP( 4,  pmulu.w.h01, 0x0000ffff0000ffff, 0xffffffff0000ffff, 0x0001000100010001 );
  
  # Halfword selection (bottom-top): 0x0005 * 0x5678 = 0x1b3e0
  TEST_RR_OP( 5,  pmulu.w.h01, 0x0001b3e00001b3e0, 0x1234000512340005, 0x56785678567856 );
  
  # Unsigned: 0xffff * 0xffff = 0xfffe0001
  TEST_RR_OP( 6,  pmulu.w.h01, 0xfffe0001fffe0001, 0xffffffffffffffff, 0xffffffffffffffff );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulu.w.h01, 0x0000000000000000, 0x0000000000000000, 0x0064006400640064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulu.w.h01, 0x0000001500000015, 0x0000000300000003, 0x0007000700070007 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulu.w.h01, 0x0000002300000023, 0x0000000500000005, 0x0007000700070007 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

