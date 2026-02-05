# See LICENSE for license details.

#*****************************************************************************
# psra_dbs.S
#-----------------------------------------------------------------------------
#
# Test psra.dbs instruction (packed shift right arithmetic double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) >> (rs2 & 0x7)
# 8 elements of 8-bits each, arithmetic shift right
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: 0x0808080808080808 >> 0 = 0x0808080808080808
  TEST_CASE_D32( 2, x14, x15, 0x0808080808080808, \
    li  x10, 0x08080808; \
    li  x11, 0x00000000; \
    li  x13, 0; \
    psra.dbs x14, x10, x12; \
  )

  # Shift by 1: 0x0808080808080808 >> 1 = 0x0404040404040404
  TEST_CASE_D32( 3, x14, x15, 0x0404040404040404, \
    li  x10, 0x08080808; \
    li  x11, 0x00000000; \
    li  x13, 1; \
    psra.dbs x14, x10, x12; \
  )

  # Shift by 2: 0x1010101010101010 >> 2 = 0x0404040404040404
  TEST_CASE_D32( 4, x14, x15, 0x0404040404040404, \
    li  x10, 0x10101010; \
    li  x11, 0x00000000; \
    li  x13, 2; \
    psra.dbs x14, x10, x12; \
  )

  # Negative shift: 0xf0f0f0f0f0f0f0f0 >> 1 = 0xf8f8f8f8f8f8f8f8 (sign extended)
  TEST_CASE_D32( 5, x14, x15, 0xf8f8f8f8f8f8f8f8, \
    li  x10, 0xf0f0f0f0; \
    li  x11, 0xffffffff; \
    li  x13, 1; \
    psra.dbs x14, x10, x12; \
  )

  # Negative shift by 4: 0x8080808080808080 >> 4 = 0xf8f8f8f8f8f8f8f8
  TEST_CASE_D32( 6, x14, x15, 0xf8f8f8f8f8f8f8f8, \
    li  x10, 0x80808080; \
    li  x11, 0xffffffff; \
    li  x13, 4; \
    psra.dbs x14, x10, x12; \
  )

  # Shift by 7: 0x7f7f7f7f7f7f7f7f >> 7 = 0x0000000000000000
  TEST_CASE_D32( 7, x14, x15, 0x0000000000000000, \
    li  x10, 0x7f7f7f7f; \
    li  x11, 0x00000000; \
    li  x13, 7; \
    psra.dbs x14, x10, x12; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

