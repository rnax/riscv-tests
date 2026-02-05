# See LICENSE for license details.

#*****************************************************************************
# predsumu_ws.S
#-----------------------------------------------------------------------------
#
# Test predsumu.ws instruction (packed unsigned reduction sum word with shift).
# Sums both unsigned words from rs1 and shifts right by rs2[4:0] bits.
# rd = (rs1[31:0] + rs1[63:32]) >> rs2[4:0]
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed unsigned reduction sum word with shift tests
  #-------------------------------------------------------------

  # Basic sum with no shift: 0x00000001 + 0x00000002 = 0x00000003
  TEST_RR_OP( 2,  predsumu.ws, 0x0000000000000003, 0x0000000200000001, 0x0000000000000000 );
  
  # All zeros
  TEST_RR_OP( 3,  predsumu.ws, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  
  # Sum with right shift by 1: (0x00000004 + 0x00000004) >> 1 = 0x00000004
  TEST_RR_OP( 4,  predsumu.ws, 0x0000000000000004, 0x0000000400000004, 0x0000000000000001 );
  
  # Large unsigned values: 0xffffffff + 0xffffffff = 0x1fffffffe >> 1 = 0xffffffff
  TEST_RR_OP( 5,  predsumu.ws, 0x00000000ffffffff, 0xffffffffffffffff, 0x0000000000000001 );
  
  # Mixed values: 0x80000000 + 0x80000000 = 0x100000000 >> 1 = 0x80000000
  TEST_RR_OP( 6,  predsumu.ws, 0x0000000080000000, 0x8000000080000000, 0x0000000000000001 );
  
  # Large values with shift: (0x40000000 + 0x40000000) >> 2 = 0x20000000
  TEST_RR_OP( 7,  predsumu.ws, 0x0000000020000000, 0x4000000040000000, 0x0000000000000002 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

