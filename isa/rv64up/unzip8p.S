# See LICENSE for license details.

#*****************************************************************************
# unzip8p.S
#-----------------------------------------------------------------------------
#
# Test unzip8p instruction (unzip 8-bit packed).
# De-interleaves 8-bit elements from rs1 into even and odd positions.
# rd = (rs1[31:24] << 24 | rs1[23:16] << 16 | rs1[15:8] << 8 | rs1[7:0])
# Extracts even-indexed bytes to lower positions, odd-indexed to upper.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Unzip 8-bit packed tests
  #-------------------------------------------------------------

  # Basic: rs1=0x02010201 -> even bytes: 0x0101, odd bytes: 0x0202
  TEST_RR_OP( 2,  unzip8p, 0x02020101, 0x02010201, 0x00000000 );
  
  # rs1=0xaaffaaff -> even: 0xffff, odd: 0xaaaa
  TEST_RR_OP( 3,  unzip8p, 0xaaaaffff, 0xaaffaaff, 0x00000000 );
  
  # rs1=0x07080304 -> even: 0x0304, odd: 0x0708
  TEST_RR_OP( 4,  unzip8p, 0x07080304, 0x07080304, 0x00000000 );
  
  # Interleaving pattern: rs1=0x77883344 -> even: 0x3344, odd: 0x7788
  TEST_RR_OP( 5,  unzip8p, 0x77883344, 0x77883344, 0x00000000 );
  
  # All zeros: rs1=0x00000000 -> 0x00000000
  TEST_RR_OP( 6,  unzip8p, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF -> 0xFFFFFFFF
  TEST_RR_OP( 7,  unzip8p, 0xffffffff, 0xffffffff, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


