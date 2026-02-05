# See LICENSE for license details.

#*****************************************************************************
# zip8hp.S
#-----------------------------------------------------------------------------
#
# Test zip8hp instruction (zip 8-bit halfword packed).
# Interleaves 8-bit elements from high halfwords of rs1 and rs2.
# rd = (rs2[31:24] << 24 | rs1[31:24] << 16 | rs2[23:16] << 8 | rs1[23:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zip 8-bit halfword packed tests
  #-------------------------------------------------------------

  # Basic: rs1=0x01020000, rs2=0x05060000 -> 0x05060102
  TEST_RR_OP( 2,  zip8hp, 0x05060102, 0x01020000, 0x05060000 );
  
  # rs1=0xFF000000, rs2=0xAA000000 -> 0xaaffaaff
  TEST_RR_OP( 3,  zip8hp, 0xaaffaaff, 0xff000000, 0xaa000000 );
  
  # rs1=0x01020304, rs2=0x05060708 -> 0x07080102
  TEST_RR_OP( 4,  zip8hp, 0x07080102, 0x01020304, 0x05060708 );
  
  # Interleaving pattern: rs1=0x11223344, rs2=0x55667788
  # Result: 0x77883344
  TEST_RR_OP( 5,  zip8hp, 0x77883344, 0x11223344, 0x55667788 );
  
  # All zeros: rs1=0x00000000, rs2=0x00000000 -> 0x00000000
  TEST_RR_OP( 6,  zip8hp, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> 0xFFFFFFFF
  TEST_RR_OP( 7,  zip8hp, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


