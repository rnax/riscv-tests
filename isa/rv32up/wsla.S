# See LICENSE for license details.

#*****************************************************************************
# wsla.S
#-----------------------------------------------------------------------------
#
# Test wsla instruction (widening shift left arithmetic to register-pair).
# rd_pair = (int64_t)(int32_t)rs1 << (rs2 & 63)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_RR_OP_PAIR( 2,  wsla, 0x00000000, 0x00000001, 0x00000001, 0x00000000 );
  # 0x00000001 << 1 = 0x0000000000000002
  TEST_RR_OP_PAIR( 3,  wsla, 0x00000000, 0x00000002, 0x00000001, 0x00000001 );
  # 0x00000001 << 31 = 0x0000000080000000
  TEST_RR_OP_PAIR( 4,  wsla, 0x00000000, 0x80000000, 0x00000001, 0x0000001f );
  # 0x00000001 << 32 = 0x0000000100000000
  TEST_RR_OP_PAIR( 5,  wsla, 0x00000001, 0x00000000, 0x00000001, 0x00000020 );
  
  # Negative: 0xFFFFFFFF << 0 = 0xFFFFFFFFFFFFFFFF (sign-extended)
  TEST_RR_OP_PAIR( 6,  wsla, 0xffffffff, 0xffffffff, 0xffffffff, 0x00000000 );
  # 0xFFFFFFFF << 1 = 0xFFFFFFFFFFFFFFFE
  TEST_RR_OP_PAIR( 7,  wsla, 0xffffffff, 0xfffffffe, 0xffffffff, 0x00000001 );
  # 0xFFFFFFFF << 32 = 0xFFFFFFFF00000000
  TEST_RR_OP_PAIR( 8,  wsla, 0xffffffff, 0x00000000, 0xffffffff, 0x00000020 );
  
  # Positive: 0x12345678 << 8 = 0x0000001234567800
  TEST_RR_OP_PAIR( 9,  wsla, 0x00000012, 0x34567800, 0x12345678, 0x00000008 );
  # Negative: 0x80000000 << 1 = 0xFFFFFFFF00000000
  TEST_RR_OP_PAIR( 10, wsla, 0xffffffff, 0x00000000, 0x80000000, 0x00000001 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, wsla, 0x00000000, 0x00000002, 0x00000001, 0x00000001 );
  TEST_RR_SRC2_EQ_DEST( 12, wsla, 0x00000000, 0x00000004, 0x00000002, 0x00000002 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, wsla, 0x00000000, 0x00000002, 0x00000001, 0x00000001 );
  TEST_RR_DEST_BYPASS( 14, 1, wsla, 0x00000000, 0x00000004, 0x00000002, 0x00000002 );
  TEST_RR_DEST_BYPASS( 15, 2, wsla, 0x00000000, 0x00000008, 0x00000004, 0x00000003 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

