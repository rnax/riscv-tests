# See LICENSE for license details.

#*****************************************************************************
# ppaireo_db.S
#-----------------------------------------------------------------------------
#
# Test ppaireo.db instruction (packed pair even-odd double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = ppaireo(rs1:rs1+1, rs2:rs2+1)
# Extracts even bytes from rs1 and odd bytes from rs2, pairs them
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair tests
  #-------------------------------------------------------------

  # Basic pairing: even from rs1, odd from rs2
  TEST_CASE_D32( 2, x14, x15, 0x0505030105050301, \
    li  x10, 0x06050403; \
    li  x11, 0x00000000; \
    li  x12, 0x02010000; \
    li  x13, 0x00000000; \
    ppaireo.db x14, x10, x12; \
  )

  # All zeros
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    ppaireo.db x14, x10, x12; \
  )

  # All ones
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0xffffffff; \
    ppaireo.db x14, x10, x12; \
  )

  # Mixed pattern
  TEST_CASE_D32( 5, x14, x15, 0xaa99aa99aa99aa99, \
    li  x10, 0xaabbaacc; \
    li  x11, 0x00000000; \
    li  x12, 0x88998899; \
    li  x13, 0x00000000; \
    ppaireo.db x14, x10, x12; \
  )

  # Different register pair
  TEST_CASE_D32( 6, x10, x11, 0x0505030105050301, \
    li  x10, 0x06050403; \
    li  x10, 0x00000000; \
    li  x11, 0x02010000; \
    li  x12, 0x00000000; \
    ppaireo.db x10, x10, x12; \
  )

  # High byte pattern
  TEST_CASE_D32( 7, x14, x15, 0xf0d0b090f0d0b090, \
    li  x10, 0xf0e0d0c0; \
    li  x11, 0x00000000; \
    li  x12, 0xb0a09080; \
    li  x13, 0x00000000; \
    ppaireo.db x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

