# See LICENSE for license details.

#*****************************************************************************
# ppaireo_b.S
#-----------------------------------------------------------------------------
#
# Test ppaireo.b instruction (packed pair even-odd byte).
# Extracts even bytes from rs1 and odd bytes from rs2.
# rd = (rs2[31:24] << 24 | rs1[23:16] << 16 | rs2[15:8] << 8 | rs1[7:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair even-odd byte tests
  #-------------------------------------------------------------

  # Basic pairing: even from rs1, odd from rs2
  TEST_RR_OP( 2,  ppaireo.b, 0x07030503, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppaireo.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppaireo.b, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern
  TEST_RR_OP( 5,  ppaireo.b, 0x99bb99bb, 0xaabbaacc, 0x88998899 );
  
  # High byte pattern
  TEST_RR_OP( 6,  ppaireo.b, 0xa0e0a0e0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppaireo.b, 0x55aa55aa, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


