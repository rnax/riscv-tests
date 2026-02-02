# See LICENSE for license details.

#*****************************************************************************
# ppairoe_db.S
#-----------------------------------------------------------------------------
#
# Test ppairoe.db instruction (packed pair odd-even double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = ppairoe(rs1:rs1+1, rs2:rs2+1)
# Extracts odd bytes from rs1 and even bytes from rs2, pairs them
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair tests
  #-------------------------------------------------------------

  # Basic pairing: odd from rs1, even from rs2
  TEST_CASE_D32( 2, x14, x15, 0x0504020006050402, \
    li  x11, 0x06050403; \
    li  x12, 0x00000000; \
    li  x13, 0x02010000; \
    li  x16, 0x00000000; \
    ppairoe.db x14, x11, x13; \
  )

  # All zeros
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    ppairoe.db x14, x11, x13; \
  )

  # All ones
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0xffffffff; \
    li  x16, 0xffffffff; \
    ppairoe.db x14, x11, x13; \
  )

  # Mixed pattern
  TEST_CASE_D32( 5, x14, x15, 0xaa88aa88aa88aa88, \
    li  x11, 0xaabbaacc; \
    li  x12, 0x00000000; \
    li  x13, 0x88998899; \
    li  x16, 0x00000000; \
    ppairoe.db x14, x11, x13; \
  )

  # Different register pair
  TEST_CASE_D32( 6, x10, x11, 0x0504020006050402, \
    li  x10, 0x06050403; \
    li  x11, 0x00000000; \
    li  x12, 0x02010000; \
    li  x13, 0x00000000; \
    ppairoe.db x10, x10, x12; \
  )

  # High byte pattern
  TEST_CASE_D32( 7, x14, x15, 0xe0c0a080f0e0d0c0, \
    li  x11, 0xf0e0d0c0; \
    li  x12, 0x00000000; \
    li  x13, 0xb0a09080; \
    li  x16, 0x00000000; \
    ppairoe.db x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

