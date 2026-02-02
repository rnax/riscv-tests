# See LICENSE for license details.

#*****************************************************************************
# wslli.S
#-----------------------------------------------------------------------------
#
# Test wslli instruction (widening shift left logical immediate).
# rd_pair = (uint64_t)(uint32_t)rs1 << shamtd
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_RI_OP_PAIR( 2,  wslli, 0x00000000, 0x00000001, 0x00000001, 0 );
  # 0x00000001 << 1 = 0x0000000000000002
  TEST_RI_OP_PAIR( 3,  wslli, 0x00000000, 0x00000002, 0x00000001, 1 );
  # 0x00000001 << 8 = 0x0000000000000100
  TEST_RI_OP_PAIR( 4,  wslli, 0x00000000, 0x00000100, 0x00000001, 8 );
  # 0x00000001 << 31 = 0x0000000080000000
  TEST_RI_OP_PAIR( 5,  wslli, 0x00000000, 0x80000000, 0x00000001, 31 );
  # 0x00000001 << 32 = 0x0000000100000000
  TEST_RI_OP_PAIR( 6,  wslli, 0x00000001, 0x00000000, 0x00000001, 32 );
  # 0x00000001 << 63 = 0x8000000000000000
  TEST_RI_OP_PAIR( 7,  wslli, 0x80000000, 0x00000000, 0x00000001, 63 );
  
  # 0xFFFFFFFF << 0 = 0x00000000FFFFFFFF
  TEST_RI_OP_PAIR( 8,  wslli, 0x00000000, 0xffffffff, 0xffffffff, 0 );
  # 0xFFFFFFFF << 1 = 0x00000001FFFFFFFE
  TEST_RI_OP_PAIR( 9,  wslli, 0x00000001, 0xfffffffe, 0xffffffff, 1 );
  # 0xFFFFFFFF << 32 = 0xFFFFFFFF00000000
  TEST_RI_OP_PAIR( 10, wslli, 0xffffffff, 0x00000000, 0xffffffff, 32 );
  
  # 0x12345678 << 8 = 0x0000001234567800
  TEST_RI_OP_PAIR( 11, wslli, 0x00000012, 0x34567800, 0x12345678, 8 );
  # 0x12345678 << 16 = 0x0000123456780000
  TEST_RI_OP_PAIR( 12, wslli, 0x00001234, 0x56780000, 0x12345678, 16 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RI_SRC1_EQ_DEST( 13, wslli, 0x00000000, 0x00000002, 0x00000001, 1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RI_DEST_BYPASS( 14, 0, wslli, 0x00000000, 0x00000002, 0x00000001, 1 );
  TEST_RI_DEST_BYPASS( 15, 1, wslli, 0x00000000, 0x00000004, 0x00000002, 2 );
  TEST_RI_DEST_BYPASS( 16, 2, wslli, 0x00000000, 0x00000008, 0x00000004, 3 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

