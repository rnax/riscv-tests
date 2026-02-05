# See LICENSE for license details.

#*****************************************************************************
# ppairo_w.S
#-----------------------------------------------------------------------------
#
# Test ppairo.w instruction (packed pair odd word).
# Extracts odd words from both rs1 and rs2.
# rd = (rs2[63:32] << 32 | rs1[63:32])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair odd word tests
  #-------------------------------------------------------------

  # Basic pairing: odd (high word) from both rs1 and rs2
  TEST_RR_OP( 2,  ppairo.w, 0x0706050407060504, 0x03020100, 0x0706050407060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppairo.w, 0x0000000000000000, 0x00000000, 0x0000000000000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppairo.w, 0xffffffffffffffff, 0xffffffff, 0xffffffffffffffff );
  
  # Mixed pattern: high word from both operands
  TEST_RR_OP( 5,  ppairo.w, 0xaabbccddaabbccdd, 0x11223344, 0xaabbccddaabbccdd );
  
  # Alternating pattern
  TEST_RR_OP( 6,  ppairo.w, 0x5555555555555555, 0x55555555, 0x5555555555555555 );
  
  # Different high words
  TEST_RR_OP( 7,  ppairo.w, 0xdeadbeefcafebabe, 0x11223344, 0xdeadbeefcafebabe );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

