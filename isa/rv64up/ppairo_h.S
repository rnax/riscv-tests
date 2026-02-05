# See LICENSE for license details.

#*****************************************************************************
# ppairo_h.S
#-----------------------------------------------------------------------------
#
# Test ppairo.h instruction (packed pair odd halfword).
# Extracts odd-indexed halfwords from rs1 and rs2 and pairs them.
# rd = (rs2[31:16] << 16 | rs1[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair odd halfword tests
  #-------------------------------------------------------------

  # Basic pairing: odd halfwords from both operands
  TEST_RR_OP( 2,  ppairo.h, 0x07060302, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppairo.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppairo.h, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern: extract halfwords 1 from each
  TEST_RR_OP( 5,  ppairo.h, 0x88998899, 0xaabbaacc, 0x88998899 );
  
  # High halfword pattern
  TEST_RR_OP( 6,  ppairo.h, 0xb0a0b0a0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppairo.h, 0x55555555, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


