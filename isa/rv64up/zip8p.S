# See LICENSE for license details.

#*****************************************************************************
# zip8p.S
#-----------------------------------------------------------------------------
#
# Test zip8p instruction (zip 8-bit packed).
# Interleaves 8-bit elements from rs1 and rs2 into a 32-bit result.
# rd = (rs2[23:16] << 24 | rs1[23:16] << 16 | rs2[7:0] << 8 | rs1[7:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zip 8-bit packed tests
  #-------------------------------------------------------------

  # Basic: rs1=0x00000001, rs2=0x00000002 -> 0x02010201
  TEST_RR_OP( 2,  zip8p, 0x02010201, 0x00000001, 0x00000002 );
  
  # rs1=0x000000FF, rs2=0x000000AA -> 0xaaffaaff
  TEST_RR_OP( 3,  zip8p, 0xaaffaaff, 0x000000ff, 0x000000aa );
  
  # rs1=0x01020304, rs2=0x05060708 -> 0x07080304
  TEST_RR_OP( 4,  zip8p, 0x07080304, 0x01020304, 0x05060708 );
  
  # Interleaving pattern: rs1=0x11223344, rs2=0x55667788
  # Result: 0x77883344
  TEST_RR_OP( 5,  zip8p, 0x77883344, 0x11223344, 0x55667788 );
  
  # All zeros: rs1=0x00000000, rs2=0x00000000 -> 0x00000000
  TEST_RR_OP( 6,  zip8p, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> 0xFFFFFFFF
  TEST_RR_OP( 7,  zip8p, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


