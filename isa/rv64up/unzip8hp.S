# See LICENSE for license details.

#*****************************************************************************
# unzip8hp.S
#-----------------------------------------------------------------------------
#
# Test unzip8hp instruction (unzip 8-bit halfword packed).
# De-interleaves 8-bit elements from high halfword of rs1.
# rd = (rs1[31:24] << 24 | rs1[31:24] << 16 | rs1[23:16] << 8 | rs1[23:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Unzip 8-bit halfword packed tests
  #-------------------------------------------------------------

  # Basic: rs1=0x05060102 -> even: 0x0102, odd: 0x0506
  TEST_RR_OP( 2,  unzip8hp, 0x05060102, 0x05060102, 0x00000000 );
  
  # rs1=0xaaffaaff -> even: 0xffff, odd: 0xaaaa
  TEST_RR_OP( 3,  unzip8hp, 0xaaaaff ff, 0xaaffaaff, 0x00000000 );
  
  # rs1=0x07080102 -> even: 0x0102, odd: 0x0708
  TEST_RR_OP( 4,  unzip8hp, 0x07080102, 0x07080102, 0x00000000 );
  
  # Interleaving pattern: rs1=0x77883344 -> even: 0x3344, odd: 0x7788
  TEST_RR_OP( 5,  unzip8hp, 0x77883344, 0x77883344, 0x00000000 );
  
  # All zeros: rs1=0x00000000 -> 0x00000000
  TEST_RR_OP( 6,  unzip8hp, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF -> 0xFFFFFFFF
  TEST_RR_OP( 7,  unzip8hp, 0xffffffff, 0xffffffff, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


