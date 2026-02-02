# See LICENSE for license details.

#*****************************************************************************
# wsll.S
#-----------------------------------------------------------------------------
#
# Test wsll instruction (widening shift left logical to register-pair).
# rd_pair = (uint64_t)(uint32_t)rs1 << (rs2 & 63)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_RR_OP_PAIR( 2,  wsll, 0x00000000, 0x00000001, 0x00000001, 0x00000000 );
  # 0x00000001 << 1 = 0x0000000000000002
  TEST_RR_OP_PAIR( 3,  wsll, 0x00000000, 0x00000002, 0x00000001, 0x00000001 );
  # 0x00000001 << 31 = 0x0000000080000000
  TEST_RR_OP_PAIR( 4,  wsll, 0x00000000, 0x80000000, 0x00000001, 0x0000001f );
  # 0x00000001 << 32 = 0x0000000100000000
  TEST_RR_OP_PAIR( 5,  wsll, 0x00000001, 0x00000000, 0x00000001, 0x00000020 );
  # 0x00000001 << 63 = 0x8000000000000000
  TEST_RR_OP_PAIR( 6,  wsll, 0x80000000, 0x00000000, 0x00000001, 0x0000003f );
  
  # 0xFFFFFFFF << 0 = 0x00000000FFFFFFFF
  TEST_RR_OP_PAIR( 7,  wsll, 0x00000000, 0xffffffff, 0xffffffff, 0x00000000 );
  # 0xFFFFFFFF << 1 = 0x00000001FFFFFFFE
  TEST_RR_OP_PAIR( 8,  wsll, 0x00000001, 0xfffffffe, 0xffffffff, 0x00000001 );
  # 0xFFFFFFFF << 32 = 0xFFFFFFFF00000000
  TEST_RR_OP_PAIR( 9,  wsll, 0xffffffff, 0x00000000, 0xffffffff, 0x00000020 );
  
  # 0x12345678 << 8 = 0x0000001234567800
  TEST_RR_OP_PAIR( 10, wsll, 0x00000012, 0x34567800, 0x12345678, 0x00000008 );
  # 0x12345678 << 16 = 0x0000123456780000
  TEST_RR_OP_PAIR( 11, wsll, 0x00001234, 0x56780000, 0x12345678, 0x00000010 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 12, wsll, 0x00000000, 0x00000002, 0x00000001, 0x00000001 );
  TEST_RR_SRC2_EQ_DEST( 13, wsll, 0x00000000, 0x00000004, 0x00000002, 0x00000002 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 14, 0, wsll, 0x00000000, 0x00000002, 0x00000001, 0x00000001 );
  TEST_RR_DEST_BYPASS( 15, 1, wsll, 0x00000000, 0x00000004, 0x00000002, 0x00000002 );
  TEST_RR_DEST_BYPASS( 16, 2, wsll, 0x00000000, 0x00000008, 0x00000004, 0x00000003 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

