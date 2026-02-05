# See LICENSE for license details.

#*****************************************************************************
# ppairoe_w.S
#-----------------------------------------------------------------------------
#
# Test ppairoe.w instruction (packed pair odd-even word).
# Extracts odd words from rs1 and even words from rs2.
# rd = (rs2[31:0] << 32 | rs1[63:32])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair odd-even word tests
  #-------------------------------------------------------------

  # Basic pairing: odd (high word) from rs1, even (low word) from rs2
  TEST_RR_OP( 2,  ppairoe.w, 0x0706050403020100, 0x03020100, 0x0000000007060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppairoe.w, 0x0000000000000000, 0x00000000, 0x0000000000000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppairoe.w, 0xffffffffffffffff, 0xffffffff, 0xffffffffffffffff );
  
  # Mixed pattern: high word from rs1, low word from rs2
  TEST_RR_OP( 5,  ppairoe.w, 0xaabbccdd11223344, 0x11223344, 0x11223344aabbccdd );
  
  # Alternating pattern
  TEST_RR_OP( 6,  ppairoe.w, 0x5555555555555555, 0x55555555, 0x5555555555555555 );
  
  # High/low word swap
  TEST_RR_OP( 7,  ppairoe.w, 0xdeadbeefcafebabe, 0xcafebabe, 0xcafebabededbeef );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

