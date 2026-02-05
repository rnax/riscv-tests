# See LICENSE for license details.

#*****************************************************************************
# predsumu_hs.S
#-----------------------------------------------------------------------------
#
# Test predsumu.hs instruction (packed reduction sum unsigned halfword).
# Sums all 2 unsigned halfwords from rs1: rd = sum(rs1[15:0], rs1[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed reduction sum unsigned halfword tests
  #-------------------------------------------------------------

  # Basic sum: 0x0001 + 0x0002 = 0x0003
  TEST_RR_OP( 2,  predsumu.hs, 0x00000003, 0x00020001, 0x00000000 );
  
  # All zeros
  TEST_RR_OP( 3,  predsumu.hs, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones (max unsigned halfword)
  TEST_RR_OP( 4,  predsumu.hs, 0x0001fffe, 0xffffffff, 0x00000000 );
  
  # Max unsigned halfwords: 65535+65535 = 131070
  TEST_RR_OP( 5,  predsumu.hs, 0x0001fffe, 0xffffffff, 0x00000000 );
  
  # Mixed values: 10000 + 20000 = 30000
  TEST_RR_OP( 6,  predsumu.hs, 0x00007530, 0x4e202710, 0x00000000 );
  
  # High halfword pattern: 40000 + 40000 = 80000
  TEST_RR_OP( 7,  predsumu.hs, 0x00013880, 0x9c409c40, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


