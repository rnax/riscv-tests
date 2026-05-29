# See LICENSE for license details.

#*****************************************************************************
# mhaccsu_h0.S
#-----------------------------------------------------------------------------
#
# Test mhaccsu.h0 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # mhaccsu.h0: rd = rd + (rs1(signed) * rs2[15:0](unsigned))[47:16]
  # Test: 0 + (0x10000000 * 0x10 >> 16) = 0 + 65536 = 65536
  TEST_CASE( 2, x14, 65536, li x14, 0; li a1, 0x10000000; li a2, 0x10; mhaccsu.h0 x14, a1, a2 );

  # Test: 5 + (0x20000000 * 0x10 >> 16) = 5 + 131072 = 131077
  TEST_CASE( 3, x14, 131077, li x14, 5; li a1, 0x20000000; li a2, 0x10; mhaccsu.h0 x14, a1, a2 );

  # Test: 10 + (0x30000000 * 0x10 >> 16) = 10 + 196608 = 196618
  TEST_CASE( 4, x14, 196618, li x14, 10; li a1, 0x30000000; li a2, 0x10; mhaccsu.h0 x14, a1, a2 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
