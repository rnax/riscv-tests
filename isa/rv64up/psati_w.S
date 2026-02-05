# See LICENSE for license details.

#*****************************************************************************
# psati_w.S
#-----------------------------------------------------------------------------
#
# Test psati.w instruction (packed saturation immediate word).
# Saturates word elements to a specified bit width.
# rd = saturate(rs1, imm) for 2 word elements
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturate to 16 bits: 0x00010000 -> 0x00007fff
  TEST_CASE( 2, x14, 0x00007fff00007fff, \
    li  x11, 0x0001000000010000; \
    psati.w x14, x11, 16; \
  )

  # No saturation needed: 0x00001000 stays 0x00001000
  TEST_CASE( 3, x14, 0x0000100000001000, \
    li  x11, 0x0000100000001000; \
    psati.w x14, x11, 16; \
  )

  # Saturate negative: 0xffff0000 -> 0xffff8000 (saturate to 16 bits signed)
  TEST_CASE( 4, x14, 0xffff8000ffff8000, \
    li  x11, 0xffff0000ffff0000; \
    psati.w x14, x11, 16; \
  )

  # Saturate to 24 bits: 0x01000000 -> 0x00ffffff
  TEST_CASE( 5, x14, 0x00ffffff00ffffff, \
    li  x11, 0x0100000001000000; \
    psati.w x14, x11, 24; \
  )

  # No saturation at 31 bits: 0x40000000 stays 0x40000000
  TEST_CASE( 6, x14, 0x4000000040000000, \
    li  x11, 0x4000000040000000; \
    psati.w x14, x11, 31; \
  )

  # Saturate to 20 bits: 0x00100000 -> 0x000fffff
  TEST_CASE( 7, x14, 0x000fffff000fffff, \
    li  x11, 0x0010000000100000; \
    psati.w x14, x11, 20; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

