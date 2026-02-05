# See LICENSE for license details.

#*****************************************************************************
# pmax_db.S
#-----------------------------------------------------------------------------
#
# Test pmax.db instruction (packed signed max double-byte).
# Returns the maximum of two packed double-byte values (signed comparison).
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  # pmax.db rd, rs1, rs2: rd:rd+1 = max(rs1:rs1+1, rs2:rs2+1) element-wise
  #-------------------------------------------------------------

  # Basic max cases
  TEST_CASE_D32( 2, x14, x15, 0x0505050505050505, \
    li  x10, 0x03030303; \
    li  x11, 0x03030303; \
    li  x12, 0x05050505; \
    li  x13, 0x05050505; \
    pmax.db x14, x10, x12; \
  )

  # Negative vs positive
  TEST_CASE_D32( 3, x14, x15, 0x0101010101010101, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x12, 0x01010101; \
    li  x13, 0x01010101; \
    pmax.db x14, x10, x12; \
  )

  # All zeros
  TEST_CASE_D32( 4, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    pmax.db x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

