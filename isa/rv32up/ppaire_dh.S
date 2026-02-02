# See LICENSE for license details.

#*****************************************************************************
# ppaire_dh.S
#-----------------------------------------------------------------------------
#
# Test ppaire.dh instruction (packed pair even double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = ppaire(rs1:rs1+1, rs2:rs2+1)
# Extracts even-indexed halfwords from both operands and pairs them
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Packed pair tests
  #-------------------------------------------------------------

  # Basic pairing: even halfwords from both operands
  TEST_CASE_D32( 2, x14, x15, 0x00020000000200000, \
    li  x11, 0x00020003; \
    li  x12, 0x00000000; \
    li  x13, 0x00000001; \
    li  x16, 0x00000000; \
    ppaire.dh x14, x11, x13; \
  )

  # All zeros
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    ppaire.dh x14, x11, x13; \
  )

  # All ones
  TEST_CASE_D32( 4, x14, x15, 0xffffffffffffffff, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    li  x13, 0xffffffff; \
    li  x16, 0xffffffff; \
    ppaire.dh x14, x11, x13; \
  )

  # Mixed pattern
  TEST_CASE_D32( 5, x14, x15, 0xaabbccddaabbccdd, \
    li  x11, 0xaabbccdd; \
    li  x12, 0x00000000; \
    li  x13, 0xaabbccdd; \
    li  x16, 0x00000000; \
    ppaire.dh x14, x11, x13; \
  )

  # Different register pair
  TEST_CASE_D32( 6, x10, x11, 0x00020000000200000, \
    li  x10, 0x00020003; \
    li  x11, 0x00000000; \
    li  x12, 0x00000001; \
    li  x13, 0x00000000; \
    ppaire.dh x10, x10, x12; \
  )

  # High halfword pattern
  TEST_CASE_D32( 7, x14, x15, 0xf0d0b090f0d0b090, \
    li  x11, 0xf0d0b090; \
    li  x12, 0x00000000; \
    li  x13, 0xf0d0b090; \
    li  x16, 0x00000000; \
    ppaire.dh x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

