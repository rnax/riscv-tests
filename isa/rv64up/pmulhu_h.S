# See LICENSE for license details.

#*****************************************************************************
# pmulhu_h.S
#-----------------------------------------------------------------------------
#
# Test pmulhu.h instruction (packed multiply high unsigned).
# rd[31:16] = (zext(rs1[31:16]) * zext(rs2[31:16])) >> 16
# rd[15:0] = (zext(rs1[15:0]) * zext(rs2[15:0])) >> 16
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic multiply: 0x0100 * 0x0100 = 0x10000, high = 1
  TEST_RR_OP( 2,  pmulhu.h, 0x00010001, 0x01000100, 0x01000100 );
  
  # Multiply with larger values: 0x1000 * 0x1000 = 0x1000000, high = 0x100
  TEST_RR_OP( 3,  pmulhu.h, 0x01000100, 0x10001000, 0x10001000 );
  
  # Unsigned multiply: 0xffff * 0x0001 = 0x0000ffff, high = 0x0000
  TEST_RR_OP( 4,  pmulhu.h, 0x00000000, 0xffffffff, 0x00010001 );
  
  # Unsigned: 0xffff * 0xffff = 0xfffe0001, high = 0xfffe
  TEST_RR_OP( 5,  pmulhu.h, 0xfffeffff, 0xffffffff, 0xffffffff );
  
  # Large unsigned: 0x8000 * 0x8000 = 0x40000000, high = 0x4000
  TEST_RR_OP( 6,  pmulhu.h, 0x40004000, 0x80008000, 0x80008000 );
  
  # Zero multiply: 0 * 100 = 0
  TEST_RR_OP( 7,  pmulhu.h, 0x00000000, 0x00000000, 0x00640064 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 8, pmulhu.h, 0x00010001, 0x01000100, 0x01000100 );
  TEST_RR_SRC2_EQ_DEST( 9, pmulhu.h, 0x00010001, 0x01000100, 0x01000100 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

