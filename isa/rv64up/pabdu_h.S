# See LICENSE for license details.

#*****************************************************************************
# pabdu_h.S
#-----------------------------------------------------------------------------
#
# Test pabdu.h instruction (packed unsigned absolute difference halfword).
# Operates on 32-bit register: rd = |rs1 - rs2| (unsigned)
# 2 elements of 16-bits each
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic difference: |1000 - 500| = 500
  TEST_CASE( 2, x14, 0x01f401f4, \
    li  x11, 0x03e803e8; \
    li  x13, 0x01f401f4; \
    pabdu.h x14, x11, x13; \
  )

  # Reverse difference: |500 - 1000| = 500
  TEST_CASE( 3, x14, 0x01f401f4, \
    li  x11, 0x01f401f4; \
    li  x13, 0x03e803e8; \
    pabdu.h x14, x11, x13; \
  )

  # Zero difference: |5000 - 5000| = 0
  TEST_CASE( 4, x14, 0x00000000, \
    li  x11, 0x13881388; \
    li  x13, 0x13881388; \
    pabdu.h x14, x11, x13; \
  )

  # Max values: |65535 - 0| = 65535
  TEST_CASE( 5, x14, 0xffffffff, \
    li  x11, 0xffffffff; \
    li  x13, 0x00000000; \
    pabdu.h x14, x11, x13; \
  )

  # Large difference: |50000 - 10000| = 40000
  TEST_CASE( 6, x14, 0x9c409c40, \
    li  x11, 0xc35043c3; \
    li  x13, 0x27102710; \
    pabdu.h x14, x11, x13; \
  )

  # All ones vs all zeros: |65535 - 0| = 65535
  TEST_CASE( 7, x14, 0xffffffff, \
    li  x11, 0xffffffff; \
    li  x13, 0x00000000; \
    pabdu.h x14, x11, x13; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

