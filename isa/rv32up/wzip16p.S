# See LICENSE for license details.

#*****************************************************************************
# wzip16p.S
#-----------------------------------------------------------------------------
#
# Test wzip16p instruction (widening zip 16-bit elements to register-pair).
# Interleaves 16-bit elements from rs1 and rs2 into a 64-bit result.
# rd_pair = (rs2[15:0] << 16 | rs1[15:0]) | (rs2[31:16] << 48 | rs1[31:16] << 32)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: rs1=0x00000001, rs2=0x00000002 -> 0x0000000200000001
  TEST_RR_OP_PAIR( 2,  wzip16p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );
  # rs1=0x0000FFFF, rs2=0x0000AAAA -> 0x0000AAAA0000FFFF
  TEST_RR_OP_PAIR( 3,  wzip16p, 0x0000aaaa, 0x0000ffff, 0x0000ffff, 0x0000aaaa );
  # rs1=0x12345678, rs2=0x9ABCDEF0 -> 0x9ABCDEF012345678
  TEST_RR_OP_PAIR( 4,  wzip16p, 0x9abcdef0, 0x12345678, 0x12345678, 0x9abcdef0 );
  
  # Interleaving pattern: rs1=0x11223344, rs2=0x55667788
  # Result: 0x5566778811223344
  TEST_RR_OP_PAIR( 5,  wzip16p, 0x55667788, 0x11223344, 0x11223344, 0x55667788 );
  
  # All zeros: rs1=0x00000000, rs2=0x00000000 -> 0x0000000000000000
  TEST_RR_OP_PAIR( 6,  wzip16p, 0x00000000, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> 0xFFFFFFFFFFFFFFFF
  TEST_RR_OP_PAIR( 7,  wzip16p, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Alternating pattern: rs1=0xAAAAAAAA, rs2=0x55555555 -> 0x5555555555555555
  TEST_RR_OP_PAIR( 8,  wzip16p, 0x55555555, 0xaaaaaaaa, 0xaaaaaaaa, 0x55555555 );
  
  # Single word in each: rs1=0x00001234, rs2=0x00005678 -> 0x0000567800001234
  TEST_RR_OP_PAIR( 9,  wzip16p, 0x00005678, 0x00001234, 0x00001234, 0x00005678 );
  
  # High word test: rs1=0xABCD0000, rs2=0xEF120000 -> 0xEF12ABCD00000000
  TEST_RR_OP_PAIR( 10, wzip16p, 0xef120000, 0xabcd0000, 0xabcd0000, 0xef120000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 11, wzip16p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );
  TEST_RR_SRC2_EQ_DEST( 12, wzip16p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 13, 0, wzip16p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );
  TEST_RR_DEST_BYPASS( 14, 1, wzip16p, 0x00000004, 0x00000003, 0x00000003, 0x00000004 );
  TEST_RR_DEST_BYPASS( 15, 2, wzip16p, 0x00000006, 0x00000005, 0x00000005, 0x00000006 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

