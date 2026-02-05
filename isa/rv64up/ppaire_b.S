# See LICENSE for license details.

#*****************************************************************************
# ppaire_b.S
#-----------------------------------------------------------------------------
#
# Test ppaire.b instruction (packed pair even byte).
# Extracts even-indexed bytes from rs1 and rs2 and pairs them.
# rd = (rs2[23:16] << 24 | rs1[23:16] << 16 | rs2[7:0] << 8 | rs1[7:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair even byte tests
  #-------------------------------------------------------------

  # Basic pairing: even bytes from both operands
  TEST_RR_OP( 2,  ppaire.b, 0x02000200, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppaire.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppaire.b, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern: extract bytes 0 and 2 from each
  TEST_RR_OP( 5,  ppaire.b, 0xaa88aa88, 0xaabbaacc, 0x88998899 );
  
  # High byte pattern
  TEST_RR_OP( 6,  ppaire.b, 0xf0d0f0d0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppaire.b, 0x55aa55aa, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


