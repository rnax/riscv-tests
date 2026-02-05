# See LICENSE for license details.

#*****************************************************************************
# psll_dws.S
#-----------------------------------------------------------------------------
#
# Test psll.dws instruction (packed shift left logical double-word).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) << (rs2 & 0x1f)
# 2 elements of 32-bits each, logical shift left
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x0000000100000001 << 0 = 0x0000000100000001
  TEST_CASE_D32( 2, x14, x15, 0x0000000100000001, \
    li  x10, 0x00000001; \
    li  x11, 0x00000000; \
    li  x13, 0; \
    psll.dws x14, x10, x12; \
  )

  # Shift by 1: 0x0000000100000001 << 1 = 0x0000000200000002
  TEST_CASE_D32( 3, x14, x15, 0x0000000200000002, \
    li  x10, 0x00000001; \
    li  x11, 0x00000000; \
    li  x13, 1; \
    psll.dws x14, x10, x12; \
  )

  # Shift by 8: 0x00000fff00000fff << 8 = 0x0fff000000fff0000
  TEST_CASE_D32( 4, x14, x15, 0x0fff000000fff0000, \
    li  x10, 0x00000fff; \
    li  x11, 0x00000000; \
    li  x13, 8; \
    psll.dws x14, x10, x12; \
  )

  # Shift by 16: 0x0000ffff0000ffff << 16 = 0xffff000000000000
  TEST_CASE_D32( 5, x14, x15, 0xffff000000000000, \
    li  x10, 0x0000ffff; \
    li  x11, 0x00000000; \
    li  x13, 16; \
    psll.dws x14, x10, x12; \
  )

  # Shift by 31: 0x0000000100000001 << 31 = 0x8000000080000000
  TEST_CASE_D32( 6, x14, x15, 0x8000000080000000, \
    li  x10, 0x00000001; \
    li  x11, 0x00000000; \
    li  x13, 31; \
    psll.dws x14, x10, x12; \
  )

  # Shift with overflow: 0xffffffffffffffff << 1 = 0xfffffffffffffffe
  TEST_CASE_D32( 7, x14, x15, 0xfffffffffffffffe, \
    li  x10, 0xffffffff; \
    li  x11, 0xffffffff; \
    li  x13, 1; \
    psll.dws x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

