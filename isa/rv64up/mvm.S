# See LICENSE for license details.

#*****************************************************************************
# mvm.S
#-----------------------------------------------------------------------------
#
# Test mvm instruction (move if non-zero).
# rd = (rs2 != 0) ? rs1 : rd
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # rs2 is non-zero: move rs1 to rd
  # rd=0x00000000, rs1=0x12345678, rs2=0x00000001 -> result=0x12345678
  TEST_CASE( 2, x3, 0x12345678, \
    li  x3, 0x00000000; \
    li  x1, 0x12345678; \
    li  x2, 0x00000001; \
    mvm x3, x1, x2; \
  )

  # rs2 is zero: keep rd unchanged
  # rd=0xABCDEF00, rs1=0x12345678, rs2=0x00000000 -> result=0xABCDEF00
  TEST_CASE( 3, x3, 0xabcdef00, \
    li  x3, 0xabcdef00; \
    li  x1, 0x12345678; \
    li  x2, 0x00000000; \
    mvm x3, x1, x2; \
  )

  # rs2 is non-zero (negative): move rs1 to rd
  # rd=0x00000000, rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> result=0xFFFFFFFF
  TEST_CASE( 4, x3, 0xffffffff, \
    li  x3, 0x00000000; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    mvm x3, x1, x2; \
  )

  # rs2 is non-zero (large): move rs1 to rd
  # rd=0x00000000, rs1=0x80000000, rs2=0x7FFFFFFF -> result=0x80000000
  TEST_CASE( 5, x3, 0x80000000, \
    li  x3, 0x00000000; \
    li  x1, 0x80000000; \
    li  x2, 0x7fffffff; \
    mvm x3, x1, x2; \
  )

  # rs2 is zero: keep rd unchanged (rd has different value)
  # rd=0x55555555, rs1=0xAAAAAAAA, rs2=0x00000000 -> result=0x55555555
  TEST_CASE( 6, x3, 0x55555555, \
    li  x3, 0x55555555; \
    li  x1, 0xaaaaaaaa; \
    li  x2, 0x00000000; \
    mvm x3, x1, x2; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 7, mvm, 0x12345678, 0x12345678, 0x00000001 );
  TEST_RR_SRC2_EQ_DEST( 8, mvm, 0xabcdef00, 0x12345678, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

