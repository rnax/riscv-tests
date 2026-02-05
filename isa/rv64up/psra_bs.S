# See LICENSE for license details.

#*****************************************************************************
# psra_bs.S
#-----------------------------------------------------------------------------
#
# Test psra.bs instruction (packed shift right arithmetic byte).
# Operates on 32-bit register: rd = rs1 >> (rs2 & 0x7) (arithmetic)
# 4 elements of 8-bits each, arithmetic shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x80808080 >> 0 = 0x80808080
  TEST_CASE( 2, x14, 0x80808080, \
    li  x13, 0x80808080; \
    li  x11, 0; \
    psra.bs x14, x13, x11; \
  )

  # Shift by 1: 0x80808080 >> 1 = 0xc0c0c0c0 (sign extended)
  TEST_CASE( 3, x14, 0xc0c0c0c0, \
    li  x13, 0x80808080; \
    li  x11, 1; \
    psra.bs x14, x13, x11; \
  )

  # Shift by 2: 0x80808080 >> 2 = 0xe0e0e0e0
  TEST_CASE( 4, x14, 0xe0e0e0e0, \
    li  x13, 0x80808080; \
    li  x11, 2; \
    psra.bs x14, x13, x11; \
  )

  # Shift by 4: 0x80808080 >> 4 = 0xf8f8f8f8
  TEST_CASE( 5, x14, 0xf8f8f8f8, \
    li  x13, 0x80808080; \
    li  x11, 4; \
    psra.bs x14, x13, x11; \
  )

  # Positive value: 0x7f7f7f7f >> 1 = 0x3f3f3f3f
  TEST_CASE( 6, x14, 0x3f3f3f3f, \
    li  x13, 0x7f7f7f7f; \
    li  x11, 1; \
    psra.bs x14, x13, x11; \
  )

  # Shift by 7: 0x80808080 >> 7 = 0xffffffff
  TEST_CASE( 7, x14, 0xffffffff, \
    li  x13, 0x80808080; \
    li  x11, 7; \
    psra.bs x14, x13, x11; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

