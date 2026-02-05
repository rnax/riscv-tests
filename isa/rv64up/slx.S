# See LICENSE for license details.

#*****************************************************************************
# slx.S
#-----------------------------------------------------------------------------
#
# Test slx instruction (shift left with sticky bit).
# Shift left, lower bits become 1 if any shifted out bits were 1.
# rd = (rs1 >> (32 - shamt)) | (rd << shamt)
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # No shift: shamt=0, rd unchanged
  # rd=0x12345678, rs1=0xABCDEF00, shamt=0 -> result=0x12345678
  TEST_CASE( 2, x3, 0x12345678, \
    li  x3, 0x12345678; \
    li  x1, 0xabcdef00; \
    li  x2, 0x00000000; \
    slx x3, x1, x2; \
  )

  # Small shift: shamt=1
  # rd=0x00000000, rs1=0x80000000, shamt=1 -> result=0x00000001
  TEST_CASE( 3, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x80000000; \
    li  x2, 0x00000001; \
    slx x3, x1, x2; \
  )

  # Shift by 8: shamt=8
  # rd=0x00000000, rs1=0xFF000000, shamt=8 -> result=0x000000FF
  TEST_CASE( 4, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0xff000000; \
    li  x2, 0x00000008; \
    slx x3, x1, x2; \
  )

  # Shift by 16: shamt=16
  # rd=0x00000000, rs1=0xFFFF0000, shamt=16 -> result=0x0000FFFF
  TEST_CASE( 5, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0xffff0000; \
    li  x2, 0x00000010; \
    slx x3, x1, x2; \
  )

  # Shift by 31: shamt=31
  # rd=0x00000000, rs1=0x00000001, shamt=31 -> result=0x00000001
  TEST_CASE( 6, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0x00000001; \
    li  x2, 0x0000001f; \
    slx x3, x1, x2; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 7, slx, 0x00000001, 0x80000000, 0x00000001 );
  TEST_RR_SRC2_EQ_DEST( 8, slx, 0x00000000, 0xff000000, 0x00000008 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

