# See LICENSE for license details.

#*****************************************************************************
# psati_h.S
#-----------------------------------------------------------------------------
#
# Test psati.h instruction (packed saturation immediate halfword).
# Saturates halfword elements to a specified bit width.
# rd = saturate(rs1, imm) for 2 halfword elements
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturate to 8 bits: 0x0100 -> 0x00ff
  TEST_CASE( 2, x14, 0x00ff00ff, \
    li  x11, 0x01000100; \
    psati.h x14, x11, 8; \
  )

  # No saturation needed: 0x0050 stays 0x0050
  TEST_CASE( 3, x14, 0x00500050, \
    li  x11, 0x00500050; \
    psati.h x14, x11, 8; \
  )

  # Saturate negative: 0xff00 -> 0xff80 (saturate to 8 bits signed)
  TEST_CASE( 4, x14, 0xff80ff80, \
    li  x11, 0xff00ff00; \
    psati.h x14, x11, 8; \
  )

  # Saturate to 12 bits: 0x1000 -> 0x0fff
  TEST_CASE( 5, x14, 0x0fff0fff, \
    li  x11, 0x10001000; \
    psati.h x14, x11, 12; \
  )

  # No saturation at 15 bits: 0x4000 stays 0x4000
  TEST_CASE( 6, x14, 0x40004000, \
    li  x11, 0x40004000; \
    psati.h x14, x11, 15; \
  )

  # Saturate to 10 bits: 0x0200 -> 0x01ff
  TEST_CASE( 7, x14, 0x01ff01ff, \
    li  x11, 0x02000200; \
    psati.h x14, x11, 10; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

