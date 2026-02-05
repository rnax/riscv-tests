# See LICENSE for license details.

#*****************************************************************************
# pnclip_bs.S
#-----------------------------------------------------------------------------
#
# Test pnclip.bs instruction (packed narrowing clip byte signed).
# rd = clip(rs1:rs1+1 >> rs2, -128, 127) per 16->8 bit element
# Uses register pairs for source.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests (uses register pairs - even registers only)
  #-------------------------------------------------------------

  # Basic: clip with shift 0
  TEST_CASE( 2, x14, 0x10101010, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    li  x12, 0x00000000; \
    pnclip.bs x14, x10, x12; \
  )

  # Shift by 1
  TEST_CASE( 3, x14, 0x08080808, \
    li  x10, 0x00100010; \
    li  x11, 0x00100010; \
    li  x12, 0x00000001; \
    pnclip.bs x14, x10, x12; \
  )

  # Zero input
  TEST_CASE( 4, x14, 0x00000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    pnclip.bs x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

