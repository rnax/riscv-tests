# See LICENSE for license details.

#*****************************************************************************
# ppairoe_dh.S
#-----------------------------------------------------------------------------
#
# Test ppairoe.dh instruction (packed pair odd-even double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = ppairoe(rs1:rs1+1, rs2:rs2+1)
# Extracts odd halfwords from rs1 and even halfwords from rs2, pairs them
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair tests
  #-------------------------------------------------------------

  # Basic pairing: odd from rs1, even from rs2
  TEST_CASE_D32( 2, x14, x15, 0x00030000000300000, \
    li  x10, 0x00020003; \
    li  x11, 0x00000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    ppairoe.dh x14, x10, x12; \
  )

  # All zeros
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    ppairoe.dh x14, x10, x12; \
  )

  # All ones
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0xffffffff; \
    ppairoe.dh x14, x10, x12; \
  )

  # Mixed pattern
  TEST_CASE_D32( 5, x14, x15, 0xaabbccddaabbccdd, \
    li  x10, 0xaabbccdd; \
    li  x11, 0x00000000; \
    li  x12, 0xaabbccdd; \
    li  x13, 0x00000000; \
    ppairoe.dh x14, x10, x12; \
  )

  # Different register pair
  TEST_CASE_D32( 6, x10, x11, 0x00030000000300000, \
    li  x10, 0x00020003; \
    li  x10, 0x00000000; \
    li  x11, 0x00000001; \
    li  x12, 0x00000000; \
    ppairoe.dh x10, x10, x12; \
  )

  # High halfword pattern
  TEST_CASE_D32( 7, x14, x15, 0xf0d0f0d0f0d0f0d0, \
    li  x10, 0xf0d0b090; \
    li  x11, 0x00000000; \
    li  x12, 0xf0d0b090; \
    li  x13, 0x00000000; \
    ppairoe.dh x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

