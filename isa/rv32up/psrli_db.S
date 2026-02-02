# See LICENSE for license details.

#*****************************************************************************
# psrli_db.S
#-----------------------------------------------------------------------------
#
# Test psrli.db instruction (packed shift right logical immediate double-byte).
# Operates on 64-bit register pairs: rd:rd+1 = (rs1:rs1+1) >> imm (imm in 0-7)
# 8 elements of 8-bits each, logical shift right by immediate
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Shift by 0: 0x0808080808080808 >> 0 = 0x0808080808080808
  TEST_CASE_D32( 2, x14, x15, 0x0808080808080808, \
    li  x11, 0x08080808; \
    li  x12, 0x00000000; \
    psrli.db x14, x11, 0; \
  )

  # Shift by 1: 0x0808080808080808 >> 1 = 0x0404040404040404
  TEST_CASE_D32( 3, x14, x15, 0x0404040404040404, \
    li  x11, 0x08080808; \
    li  x12, 0x00000000; \
    psrli.db x14, x11, 1; \
  )

  # Shift by 2: 0x1010101010101010 >> 2 = 0x0404040404040404
  TEST_CASE_D32( 4, x14, x15, 0x0404040404040404, \
    li  x11, 0x10101010; \
    li  x12, 0x00000000; \
    psrli.db x14, x11, 2; \
  )

  # Logical shift (no sign extension): 0xf0f0f0f0f0f0f0f0 >> 1 = 0x7878787878787878
  TEST_CASE_D32( 5, x14, x15, 0x7878787878787878, \
    li  x11, 0xf0f0f0f0; \
    li  x12, 0xffffffff; \
    psrli.db x14, x11, 1; \
  )

  # Logical shift by 4: 0x8080808080808080 >> 4 = 0x0808080808080808
  TEST_CASE_D32( 6, x14, x15, 0x0808080808080808, \
    li  x11, 0x80808080; \
    li  x12, 0xffffffff; \
    psrli.db x14, x11, 4; \
  )

  # Shift by 7: 0xffffffffffffffff >> 7 = 0x0101010101010101
  TEST_CASE_D32( 7, x14, x15, 0x0101010101010101, \
    li  x11, 0xffffffff; \
    li  x12, 0xffffffff; \
    psrli.db x14, x11, 7; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

