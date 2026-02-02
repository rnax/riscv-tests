# See LICENSE for license details.

#*****************************************************************************
# psa_dhx.S
#-----------------------------------------------------------------------------
#
# Test psa.dhx instruction (packed saturating add-sub double-halfword cross).
# Operates on 64-bit register pairs with saturation: rd:rd+1 = sat(rs1_hi + rs2_hi, rs1_lo - rs2_lo)
# 2 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic: (0x0005 + 0x0005, 0x0003 - 0x0003) = (0x000a, 0x0000)
  TEST_CASE_D32( 2, x14, x15, 0x0000000a, \
    li  x11, 0x00050003; \
    li  x12, 0x00000000; \
    li  x13, 0x00050003; \
    li  x16, 0x00000000; \
    psa.dhx x14, x11, x13; \
  )

  # Zero case: (0x0000 + 0x0000, 0x0000 - 0x0000) = (0x0000, 0x0000)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    li  x16, 0x00000000; \
    psa.dhx x14, x11, x13; \
  )

  # Saturation on add: (0x7fff + 0x7fff, 0x0050 - 0x0100) = (0x7fff, 0xffb0) [saturated]
  TEST_CASE_D32( 4, x14, x15, 0xffb07fff, \
    li  x11, 0x7fff0050; \
    li  x12, 0x00000000; \
    li  x13, 0x7fff0100; \
    li  x16, 0x00000000; \
    psa.dhx x14, x11, x13; \
  )

  # Saturation on sub: (0x0001 + 0x0001, 0x8000 - 0x7fff) = (0x0002, 0x8001) [saturated]
  TEST_CASE_D32( 5, x14, x15, 0x80010002, \
    li  x11, 0x00018000; \
    li  x12, 0x00000000; \
    li  x13, 0x00017fff; \
    li  x16, 0x00000000; \
    psa.dhx x14, x11, x13; \
  )

  # Negative values: (0xff00 + 0xff00, 0xff00 - 0xff00) = (0xfe00, 0x0000)
  TEST_CASE_D32( 6, x14, x15, 0x0000fe00, \
    li  x11, 0xff00ff00; \
    li  x12, 0xffffffff; \
    li  x13, 0xff00ff00; \
    li  x16, 0xffffffff; \
    psa.dhx x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

