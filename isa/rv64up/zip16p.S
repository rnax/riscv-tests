# See LICENSE for license details.

#*****************************************************************************
# zip16p.S
#-----------------------------------------------------------------------------
#
# Test zip16p instruction (zip 16-bit packed).
# Interleaves 16-bit elements from rs1 and rs2 into a 32-bit result.
# rd = (rs2[15:0] << 16 | rs1[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zip 16-bit packed tests
  #-------------------------------------------------------------

  # Basic: rs1=0x00000001, rs2=0x00000002 -> 0x00020001
  TEST_RR_OP( 2,  zip16p, 0x00020001, 0x00000001, 0x00000002 );
  
  # rs1=0x0000FFFF, rs2=0x0000AAAA -> 0xaaaaffff
  TEST_RR_OP( 3,  zip16p, 0xaaaaffff, 0x0000ffff, 0x0000aaaa );
  
  # rs1=0x01020304, rs2=0x05060708 -> 0x07080304
  TEST_RR_OP( 4,  zip16p, 0x07080304, 0x01020304, 0x05060708 );
  
  # Interleaving pattern: rs1=0x11223344, rs2=0x55667788
  # Result: 0x77883344
  TEST_RR_OP( 5,  zip16p, 0x77883344, 0x11223344, 0x55667788 );
  
  # All zeros: rs1=0x00000000, rs2=0x00000000 -> 0x00000000
  TEST_RR_OP( 6,  zip16p, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> 0xFFFFFFFF
  TEST_RR_OP( 7,  zip16p, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

