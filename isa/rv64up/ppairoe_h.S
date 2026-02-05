# See LICENSE for license details.

#*****************************************************************************
# ppairoe_h.S
#-----------------------------------------------------------------------------
#
# Test ppairoe.h instruction (packed pair odd-even halfword).
# Extracts odd halfword from rs1 and even halfword from rs2.
# rd = (rs2[15:0] << 16 | rs1[31:16])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair odd-even halfword tests
  #-------------------------------------------------------------

  # Basic pairing: odd from rs1, even from rs2
  TEST_RR_OP( 2,  ppairoe.h, 0x05010302, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppairoe.h, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppairoe.h, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern
  TEST_RR_OP( 5,  ppairoe.h, 0x8899aacc, 0xaabbaacc, 0x88998899 );
  
  # High halfword pattern
  TEST_RR_OP( 6,  ppairoe.h, 0x9080d0c0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppairoe.h, 0x5555aaaa, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


