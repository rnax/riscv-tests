# See LICENSE for license details.

#*****************************************************************************
# pusati_dh.S
#-----------------------------------------------------------------------------
#
# Test pusati.dh instruction (packed unsigned saturation immediate double-halfword).
# Operates on 64-bit register pairs: rd:rd+1 = SAT(rs1:rs1+1, shamtw + 1) [unsigned]
# 4 elements of 16-bits each, with saturation to specified bit width
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Saturation to 1-bit: 0x0001 -> 0x0001 (saturates to 1)
  TEST_CASE_D32( 2, x14, x15, 0x0001000100010001, \
    li  x10, 0x00010001; \
    li  x11, 0x00000000; \
    pusati.dh x14, x11, 0; \
  )

  # Saturation to 8-bit: 0x00FF -> 0x00FF (fits)
  TEST_CASE_D32( 3, x14, x15, 0x00ff00ff00ff00ff, \
    li  x10, 0x00ff00ff; \
    li  x11, 0x00000000; \
    pusati.dh x14, x11, 7; \
  )

  # Saturation to 8-bit: 0x0100 -> 0x00FF (saturates)
  TEST_CASE_D32( 4, x14, x15, 0x00ff00ff00ff00ff, \
    li  x10, 0x01000100; \
    li  x11, 0x00000000; \
    pusati.dh x14, x11, 7; \
  )

  # Saturation to 16-bit: 0xFFFF -> 0xFFFF (fits)
  TEST_CASE_D32( 5, x14, x15, 0xffffffffffffffff, \
    li  x10, 0xffffffff; \
    li  x11, 0x00000000; \
    pusati.dh x14, x11, 15; \
  )

  # Saturation to 16-bit: 0x10000 -> 0xFFFF (saturates)
  TEST_CASE_D32( 6, x14, x15, 0xffffffffffffffff, \
    li  x10, 0x00010001; \
    li  x11, 0x00000000; \
    pusati.dh x14, x11, 15; \
  )

  # Zero input
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x10, 0x00000000; \
    li  x11, 0x00000000; \
    pusati.dh x14, x11, 7; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

