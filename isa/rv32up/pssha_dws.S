# See LICENSE for license details.

#*****************************************************************************
# pssha_dws.S
#-----------------------------------------------------------------------------
#
# Test pssha.dws instruction (packed saturating shift left arithmetic double-word).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1 << shamt)
# 2 elements of 32-bits each, with saturation
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic left shift: 0x00000001 << 1 = 0x00000002
  TEST_CASE_D32( 2, x14, x15, 0x0000000200000002, \
    li  x11, 0x00000001; \
    li  x12, 0x00000001; \
    pssha.dws x14, x11, 1; \
  )

  # Left shift: 0x00000005 << 2 = 0x00000014
  TEST_CASE_D32( 3, x14, x15, 0x0000001400000014, \
    li  x11, 0x00000005; \
    li  x12, 0x00000005; \
    pssha.dws x14, x11, 2; \
  )

  # Saturation on left shift: 0x40000000 << 1 saturates to 0x7FFFFFFF
  TEST_CASE_D32( 4, x14, x15, 0x7fffffff7fffffff, \
    li  x11, 0x40000000; \
    li  x12, 0x40000000; \
    pssha.dws x14, x11, 1; \
  )

  # Saturation on left shift: 0xC0000000 << 1 saturates to 0x80000000
  TEST_CASE_D32( 5, x14, x15, 0x8000000080000000, \
    li  x11, 0xc0000000; \
    li  x12, 0xc0000000; \
    pssha.dws x14, x11, 1; \
  )

  # Zero input
  TEST_CASE_D32( 6, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    pssha.dws x14, x11, 1; \
  )

  # Zero shift amount
  TEST_CASE_D32( 7, x14, x15, 0x0000000500000005, \
    li  x11, 0x00000005; \
    li  x12, 0x00000005; \
    pssha.dws x14, x11, 0; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

