# See LICENSE for license details.

#*****************************************************************************
# predsumu_bs.S
#-----------------------------------------------------------------------------
#
# Test predsumu.bs instruction (packed reduction sum unsigned byte).
# Sums all 4 unsigned bytes from rs1: rd = sum(rs1[7:0], rs1[15:8], rs1[23:16], rs1[31:24])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum unsigned byte tests
  #-------------------------------------------------------------

  # Basic sum: 1+2+3+4 = 10
  TEST_RR_OP( 2,  predsumu.bs, 0x0000000a, 0x04030201, 0x00000000 );
  
  # All zeros
  TEST_RR_OP( 3,  predsumu.bs, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  predsumu.bs, 0x000000fc, 0xffffffff, 0x00000000 );
  
  # Max unsigned bytes: 255+255+255+255 = 1020
  TEST_RR_OP( 5,  predsumu.bs, 0x000003fc, 0xffffffff, 0x00000000 );
  
  # Mixed values: 100+200+50+150 = 500
  TEST_RR_OP( 6,  predsumu.bs, 0x000001f4, 0x9632c864, 0x00000000 );
  
  # High byte pattern: 200+200+200+200 = 800
  TEST_RR_OP( 7,  predsumu.bs, 0x00000320, 0xc8c8c8c8, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


