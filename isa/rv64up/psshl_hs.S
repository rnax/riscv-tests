# See LICENSE for license details.

#*****************************************************************************
# psshl_hs.S
#-----------------------------------------------------------------------------
#
# Test psshl.hs instruction (packed saturating shift left halfword).
# Bidirectional saturating shift on each 16-bit element:
# positive shamt = left shift with saturation, negative shamt = right shift (logical).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # psshl.hs rd, rs1, rs2
  # For each 16-bit element:
  # If rs2[7:0] >= 0: left shift with saturation to 16-bit max
  # If rs2[7:0] < 0: right shift logical

  # Test case 1: Left shift without saturation
  # rs1 = 0x00050005, rs2 = 0x00000002 (shift left by 2)
  # Expected: 0x00140014 (5 << 2 = 20 in each halfword)
  TEST_RR_OP_VXSAT( 2, psshl.hs, 0x00140014, 0x00050005, 0x00000002, 0  );

  # Test case 2: Left shift with saturation (all 4 halfword lanes)
  # rs1 = 0x4000400040004000, rs2 = 0x00000002 (shift left by 2)
  # All 4 halfwords 0x4000<<2=0x10000>0xFFFF, saturate to 0xFFFF; result = 0xFFFFFFFFFFFFFFFF
  TEST_RR_OP_VXSAT( 3, psshl.hs, 0xFFFFFFFFFFFFFFFF, 0x4000400040004000, 0x00000002, 1  );
 

  # Test case 3: Left shift by 0
  # rs1 = 0x12345678, rs2 = 0x00000000
  # Expected: 0x12345678 (no change)
  TEST_RR_OP_VXSAT( 4, psshl.hs, 0x12345678, 0x12345678, 0x00000000, 0  );

  # Test case 4: Left shift by large amount (>= 16), all 4 halfword lanes
  # rs1 = 0x0001000100010001, rs2 = 0x00000010 (shift left by 16)
  # All 4 halfwords 0x0001 with sshamt=16: shx=0x00010000>0xFFFF, saturate to 0xFFFF; result = 0xFFFFFFFFFFFFFFFF
  TEST_RR_OP_VXSAT( 5, psshl.hs, 0xFFFFFFFFFFFFFFFF, 0x0001000100010001, 0x00000010, 1  );

  # Test case 5: Right shift (negative shamt)
  # rs1 = 0x80008000, rs2 = 0xFFFFFFFC (shift right by 4)
  # li loads 0x0000000080008000 on RV64 (positive, no sign-extension); upper halfwords 0x0000>>4=0x0000, lower 0x8000>>4=0x0800
  # Expected: 0x08000800
  TEST_RR_OP_VXSAT( 6, psshl.hs, 0x08000800, 0x80008000, 0xFFFFFFFC, 0  );

  # Test case 6: Right shift by large negative amount (<= -16)
  # rs1 = 0xFFFFFFFF, rs2 = 0xFFFFFFF0 (shift right by 16)
  # Expected: 0x00000000
  TEST_RR_OP_VXSAT( 7, psshl.hs, 0x00000000, 0xFFFFFFFF, 0xFFFFFFF0, 0  );

  # Test case 7: Right shift by -1
  # rs1 = 0x12345678, rs2 = 0xFFFFFFFF (shift right by 1)
  # Expected: 0x091A2B3C
  TEST_RR_OP_VXSAT( 8, psshl.hs, 0x091A2B3C, 0x12345678, 0xFFFFFFFF, 0  );

  # Test case 8: Saturation with maximum value (all 4 halfword lanes)
  # rs1 = 0x7FFF7FFF7FFF7FFF, rs2 = 0x00000002 (shift left by 2)
  # All 4 halfwords 0x7FFF<<2=0x1FFFC>0xFFFF, saturate to 0xFFFF; result = 0xFFFFFFFFFFFFFFFF
  TEST_RR_OP_VXSAT( 9, psshl.hs, 0xFFFFFFFFFFFFFFFF, 0x7FFF7FFF7FFF7FFF, 0x00000002, 1  );

  # Test case 9: Zero shifted
  # rs1 = 0x00000000, rs2 = 0x00000005
  # Expected: 0x00000000
  TEST_RR_OP_VXSAT( 10, psshl.hs, 0x00000000, 0x00000000, 0x00000005, 0  );

  # Test case 10: Mixed values
  # rs1 = 0x0001FFFF, rs2 = 0x00000001 (shift left by 1)
  # Expected: 0x0002FFFF (0x0001 << 1 = 0x0002, 0xFFFF saturates to 0xFFFF)
  TEST_RR_OP_VXSAT( 11, psshl.hs, 0x0002FFFF, 0x0001FFFF, 0x00000001, 1  );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END


