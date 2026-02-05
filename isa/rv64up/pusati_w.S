# See LICENSE for license details.

#*****************************************************************************
# pusati_w.S
#-----------------------------------------------------------------------------
#
# Test pusati.w instruction (packed unsigned saturation immediate word).
# Saturates word elements to a specified bit width (unsigned).
# rd = saturate_unsigned(rs1, imm) for 2 word elements
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturate to 16 bits unsigned: 0x00010000 -> 0x0000ffff
  TEST_CASE( 2, x14, 0x0000ffff0000ffff, \
    li  x11, 0x0001000000010000; \
    pusati.w x14, x11, 16; \
  )

  # No saturation needed: 0x00001000 stays 0x00001000
  TEST_CASE( 3, x14, 0x0000100000001000, \
    li  x11, 0x0000100000001000; \
    pusati.w x14, x11, 16; \
  )

  # Saturate large value: 0xffffffff -> 0x0000ffff (saturate to 16 bits unsigned)
  TEST_CASE( 4, x14, 0x0000ffff0000ffff, \
    li  x11, 0xffffffffffffffff; \
    pusati.w x14, x11, 16; \
  )

  # Saturate to 24 bits unsigned: 0x01000000 -> 0x00ffffff
  TEST_CASE( 5, x14, 0x00ffffff00ffffff, \
    li  x11, 0x0100000001000000; \
    pusati.w x14, x11, 24; \
  )

  # Saturate to 31 bits (max valid): large value -> 0x7fffffff
  TEST_CASE( 6, x14, 0x7fffffff7fffffff, \
    li  x11, 0xffffffffffffffff; \
    pusati.w x14, x11, 31; \
  )

  # Saturate to 20 bits unsigned: 0x00100000 -> 0x000fffff
  TEST_CASE( 7, x14, 0x000fffff000fffff, \
    li  x11, 0x0010000000100000; \
    pusati.w x14, x11, 20; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

