# See LICENSE for license details.

#*****************************************************************************
# ppaire_h.S
#-----------------------------------------------------------------------------
#
# Test ppaire.h instruction (packed pair even halfword).
# Extracts even-indexed halfwords from rs1 and rs2 and pairs them.
# rd = (rs2[31:16] << 16 | rs1[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair even halfword tests
  #-------------------------------------------------------------

  # Basic pairing: even halfwords from both operands
  TEST_RR_OP( 2,  ppaire.h, 0x07050301, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppaire.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppaire.h, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern: extract halfwords 0 from each
  TEST_RR_OP( 5,  ppaire.h, 0x88998899, 0xaabbaacc, 0x88998899 );
  
  # High halfword pattern
  TEST_RR_OP( 6,  ppaire.h, 0xb0a0f0e0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppaire.h, 0x55555555, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


