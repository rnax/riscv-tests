# See LICENSE for license details.

#*****************************************************************************
# paas_dhx.S
#-----------------------------------------------------------------------------
#
# Test paas.dhx instruction (packed add-sub cross double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1_hi + rs2_lo, rs1_lo - rs2_hi)
# 2 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic cross: (0x0005 + 0x0003, 0x0003 - 0x0005) = (0x0008, 0xfffe)
  TEST_CASE_D32( 2, x14, x15, 0xfffeffffe, \
    li  x10, 0x00050003; \
    li  x11, 0x00000000; \
    li  x12, 0x00050003; \
    li  x13, 0x00000000; \
    paas.dhx x14, x10, x12; \
  )

  # Zero case: (0x0000 + 0x0000, 0x0000 - 0x0000) = (0x0000, 0x0000)
  TEST_CASE_D32( 3, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    li  x12, 0x00000000; \
    li  x13, 0x00000000; \
    paas.dhx x14, x10, x12; \
  )

  # Positive add, negative sub: (0x0100 + 0x0050, 0x0050 - 0x0100) = (0x0150, 0xffb0)
  TEST_CASE_D32( 4, x14, x15, 0xffb00150, \
    li  x10, 0x01000050; \
    li  x11, 0x00000000; \
    li  x12, 0x01000050; \
    li  x13, 0x00000000; \
    paas.dhx x14, x10, x12; \
  )

  # Large values: (0x7fff + 0x0001, 0x0001 - 0x7fff) = (0x8000, 0x8002)
  TEST_CASE_D32( 5, x14, x15, 0x80028000, \
    li  x10, 0x7fff0001; \
    li  x11, 0x00000000; \
    li  x12, 0x7fff0001; \
    li  x13, 0x00000000; \
    paas.dhx x14, x10, x12; \
  )

  # Negative values: (0xff00 + 0xff00, 0xff00 - 0xff00) = (0xfe00, 0x0000)
  TEST_CASE_D32( 6, x14, x15, 0x0000fe00, \
    li  x10, 0xff00ff00; \
    li  x11, 0xffffffff; \
    li  x12, 0xff00ff00; \
    li  x13, 0xffffffff; \
    paas.dhx x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

