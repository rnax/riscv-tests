# See LICENSE for license details.

#*****************************************************************************
# wslai.S
#-----------------------------------------------------------------------------
#
# Test wslai instruction (widening shift left arithmetic immediate).
# rd_pair = (int64_t)(int32_t)rs1 << shamtd
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic shift: 0x00000001 << 0 = 0x0000000000000001
  TEST_RI_OP_PAIR( 2,  wslai, 0x00000000, 0x00000001, 0x00000001, 0 );
  # 0x00000001 << 1 = 0x0000000000000002
  TEST_RI_OP_PAIR( 3,  wslai, 0x00000000, 0x00000002, 0x00000001, 1 );
  # 0x00000001 << 8 = 0x0000000000000100
  TEST_RI_OP_PAIR( 4,  wslai, 0x00000000, 0x00000100, 0x00000001, 8 );
  # 0x00000001 << 31 = 0x0000000080000000
  TEST_RI_OP_PAIR( 5,  wslai, 0x00000000, 0x80000000, 0x00000001, 31 );
  # 0x00000001 << 32 = 0x0000000100000000
  TEST_RI_OP_PAIR( 6,  wslai, 0x00000001, 0x00000000, 0x00000001, 32 );
  
  # Negative: 0xFFFFFFFF << 0 = 0xFFFFFFFFFFFFFFFF (sign-extended)
  TEST_RI_OP_PAIR( 7,  wslai, 0xffffffff, 0xffffffff, 0xffffffff, 0 );
  # 0xFFFFFFFF << 1 = 0xFFFFFFFFFFFFFFFE
  TEST_RI_OP_PAIR( 8,  wslai, 0xffffffff, 0xfffffffe, 0xffffffff, 1 );
  # 0xFFFFFFFF << 32 = 0xFFFFFFFF00000000
  TEST_RI_OP_PAIR( 9,  wslai, 0xffffffff, 0x00000000, 0xffffffff, 32 );
  
  # Positive: 0x12345678 << 8 = 0x0000001234567800
  TEST_RI_OP_PAIR( 10, wslai, 0x00000012, 0x34567800, 0x12345678, 8 );
  # Negative: 0x80000000 << 1 = 0xFFFFFFFF00000000
  TEST_RI_OP_PAIR( 11, wslai, 0xffffffff, 0x00000000, 0x80000000, 1 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RI_SRC1_EQ_DEST( 12, wslai, 0x00000000, 0x00000002, 0x00000001, 1 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RI_DEST_BYPASS( 13, 0, wslai, 0x00000000, 0x00000002, 0x00000001, 1 );
  TEST_RI_DEST_BYPASS( 14, 1, wslai, 0x00000000, 0x00000004, 0x00000002, 2 );
  TEST_RI_DEST_BYPASS( 15, 2, wslai, 0x00000000, 0x00000008, 0x00000004, 3 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

