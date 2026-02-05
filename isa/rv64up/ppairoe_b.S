# See LICENSE for license details.

#*****************************************************************************
# ppairoe_b.S
#-----------------------------------------------------------------------------
#
# Test ppairoe.b instruction (packed pair odd-even byte).
# Extracts odd bytes from rs1 and even bytes from rs2.
# rd = (rs2[23:16] << 24 | rs1[31:24] << 16 | rs2[7:0] << 8 | rs1[15:8])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair odd-even byte tests
  #-------------------------------------------------------------

  # Basic pairing: odd from rs1, even from rs2
  TEST_RR_OP( 2,  ppairoe.b, 0x06020602, 0x03020100, 0x07060504 );
  
  # All zeros
  TEST_RR_OP( 3,  ppairoe.b, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppairoe.b, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Mixed pattern
  TEST_RR_OP( 5,  ppairoe.b, 0xaa88aa88, 0xaabbaacc, 0x88998899 );
  
  # High byte pattern
  TEST_RR_OP( 6,  ppairoe.b, 0xd0c0d0c0, 0xf0e0d0c0, 0xb0a09080 );
  
  # Alternating pattern
  TEST_RR_OP( 7,  ppairoe.b, 0xaa55aa55, 0xaaaaaaaa, 0x55555555 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


