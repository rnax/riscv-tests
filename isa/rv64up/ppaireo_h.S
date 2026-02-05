# See LICENSE for license details.

#*****************************************************************************
# ppaireo_h.S
#-----------------------------------------------------------------------------
#
# Test ppaireo.h instruction (packed pair even-odd halfword).
# Extracts even halfword from rs1 and odd halfword from rs2.
# rd = (rs2[31:16] << 16 | rs1[15:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair even-odd halfword tests
  #-------------------------------------------------------------

  # Basic pairing: even from rs1, odd from rs2
  TEST_RR_OP( 2,  ppaireo.h, 0x07050100, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppaireo.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppaireo.h, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern
  TEST_RR_OP( 5,  ppaireo.h, 0x8899aacc, 0xaabbaacc, 0x88998899 );
  
  # High halfword pattern
  TEST_RR_OP( 6,  ppaireo.h, 0xb0a0d0c0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppaireo.h, 0x5555aaaa, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


