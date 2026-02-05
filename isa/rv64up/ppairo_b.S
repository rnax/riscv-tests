# See LICENSE for license details.

#*****************************************************************************
# ppairo_b.S
#-----------------------------------------------------------------------------
#
# Test ppairo.b instruction (packed pair odd byte).
# Extracts odd-indexed bytes from rs1 and rs2 and pairs them.
# rd = (rs2[31:24] << 24 | rs1[31:24] << 16 | rs2[15:8] << 8 | rs1[15:8])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair odd byte tests
  #-------------------------------------------------------------

  # Basic pairing: odd bytes from both operands
  TEST_RR_OP( 2,  ppairo.b, 0x07050301, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppairo.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppairo.b, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern: extract bytes 1 and 3 from each
  TEST_RR_OP( 5,  ppairo.b, 0x99bb99bb, 0xaabbaacc, 0x88998899 );
  
  # High byte pattern
  TEST_RR_OP( 6,  ppairo.b, 0xe0c0e0c0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppairo.b, 0xaa55aa55, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


