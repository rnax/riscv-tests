# See LICENSE for license details.

#*****************************************************************************
# unzip16hp.S
#-----------------------------------------------------------------------------
#
# Test unzip16hp instruction (unzip 16-bit halfword packed).
# De-interleaves 16-bit elements from high halfword of rs1.
# rd = (rs1[31:16] << 16 | rs1[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Unzip 16-bit halfword packed tests
  #-------------------------------------------------------------

  # Basic: rs1=0x05060102 -> even: 0x0102, odd: 0x0506
  TEST_RR_OP( 2,  unzip16hp, 0x05060102, 0x05060102, 0x00000000 );
  
  # rs1=0xaaffaaff -> even: 0xaaff, odd: 0xaaff
  TEST_RR_OP( 3,  unzip16hp, 0xaaffaaff, 0xaaffaaff, 0x00000000 );
  
  # rs1=0x07080102 -> even: 0x0102, odd: 0x0708
  TEST_RR_OP( 4,  unzip16hp, 0x07080102, 0x07080102, 0x00000000 );
  
  # Interleaving pattern: rs1=0x77883344 -> even: 0x3344, odd: 0x7788
  TEST_RR_OP( 5,  unzip16hp, 0x77883344, 0x77883344, 0x00000000 );
  
  # All zeros: rs1=0x00000000 -> 0x00000000
  TEST_RR_OP( 6,  unzip16hp, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF -> 0xFFFFFFFF
  TEST_RR_OP( 7,  unzip16hp, 0xffffffff, 0xffffffff, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


