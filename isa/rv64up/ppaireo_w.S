# See LICENSE for license details.

#*****************************************************************************
# ppaireo_w.S
#-----------------------------------------------------------------------------
#
# Test ppaireo.w instruction (packed pair even-odd word).
# Extracts even words from rs1 and odd words from rs2.
# rd = (rs2[63:32] << 32 | rs1[31:0])
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair even-odd word tests
  #-------------------------------------------------------------

  # Basic pairing: even (low word) from rs1, odd (high word) from rs2
  TEST_RR_OP( 2,  ppaireo.w, 0x0706050403020100, 0x03020100, 0x0706050400000000 );
  
  # All zeros
  TEST_RR_OP( 3,  ppaireo.w, 0x0000000000000000, 0x00000000, 0x0000000000000000 );
  
  # All ones
  TEST_RR_OP( 4,  ppaireo.w, 0xffffffffffffffff, 0xffffffff, 0xffffffffffffffff );
  
  # Mixed pattern: low word from rs1, high word from rs2
  TEST_RR_OP( 5,  ppaireo.w, 0xaabbccdd11223344, 0x11223344, 0xaabbccdd00000000 );
  
  # Alternating pattern
  TEST_RR_OP( 6,  ppaireo.w, 0x5555555555555555, 0x55555555, 0x5555555500000000 );
  
  # High/low word swap
  TEST_RR_OP( 7,  ppaireo.w, 0xdeadbeefcafebabe, 0xcafebabe, 0xdeadbeef00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

