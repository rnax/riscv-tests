# See LICENSE for license details.

#*****************************************************************************
# wzip8p.S
#-----------------------------------------------------------------------------
#
# Test wzip8p instruction (widening zip 8-bit elements to register-pair).
# Interleaves 8-bit elements from rs1 and rs2 into a 64-bit result.
# rd_pair = (rs2[7:0] << 8 | rs1[7:0]) | (rs2[15:8] << 24 | rs1[15:8] << 16) | ...
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: rs1=0x00000001, rs2=0x00000002 -> 0x0000000200000001
  TEST_RR_OP_PAIR( 2,  wzip8p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );
  # rs1=0x000000FF, rs2=0x000000AA -> 0x000000AA000000FF
  TEST_RR_OP_PAIR( 3,  wzip8p, 0x000000aa, 0x000000ff, 0x000000ff, 0x000000aa );
  # rs1=0x01020304, rs2=0x05060708 -> 0x0506070801020304
  TEST_RR_OP_PAIR( 4,  wzip8p, 0x05060708, 0x01020304, 0x01020304, 0x05060708 );
  
  # Interleaving pattern: rs1=0x11223344, rs2=0x55667788
  # Result: 0x5566778811223344
  TEST_RR_OP_PAIR( 5,  wzip8p, 0x55667788, 0x11223344, 0x11223344, 0x55667788 );
  
  # All zeros: rs1=0x00000000, rs2=0x00000000 -> 0x0000000000000000
  TEST_RR_OP_PAIR( 6,  wzip8p, 0x00000000, 0x00000000, 0x00000000, 0x00000000 );
  
  # All ones: rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> 0xFFFFFFFFFFFFFFFF
  TEST_RR_OP_PAIR( 7,  wzip8p, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff );
  
  # Alternating pattern: rs1=0xAAAAAAAA, rs2=0x55555555 -> 0x5555555555555555
  TEST_RR_OP_PAIR( 8,  wzip8p, 0x55555555, 0xaaaaaaaa, 0xaaaaaaaa, 0x55555555 );
  
  # Single byte in each: rs1=0x00000012, rs2=0x00000034 -> 0x0000003400000012
  TEST_RR_OP_PAIR( 9,  wzip8p, 0x00000034, 0x00000012, 0x00000012, 0x00000034 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 10, wzip8p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );
  TEST_RR_SRC2_EQ_DEST( 11, wzip8p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 12, 0, wzip8p, 0x00000002, 0x00000001, 0x00000001, 0x00000002 );
  TEST_RR_DEST_BYPASS( 13, 1, wzip8p, 0x00000004, 0x00000003, 0x00000003, 0x00000004 );
  TEST_RR_DEST_BYPASS( 14, 2, wzip8p, 0x00000006, 0x00000005, 0x00000005, 0x00000006 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

