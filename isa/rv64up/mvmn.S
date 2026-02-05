# See LICENSE for license details.

#*****************************************************************************
# mvmn.S
#-----------------------------------------------------------------------------
#
# Test mvmn instruction (move if zero).
# rd = (rs2 == 0) ? rs1 : rd
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # rs2 is zero: move rs1 to rd
  # rd=0x00000000, rs1=0x12345678, rs2=0x00000000 -> result=0x12345678
  TEST_CASE( 2, x3, 0x12345678, \
    li  x3, 0x00000000; \
    li  x1, 0x12345678; \
    li  x2, 0x00000000; \
    mvmn x3, x1, x2; \
  )

  # rs2 is non-zero: keep rd unchanged
  # rd=0xABCDEF00, rs1=0x12345678, rs2=0x00000001 -> result=0xABCDEF00
  TEST_CASE( 3, x3, 0xabcdef00, \
    li  x3, 0xabcdef00; \
    li  x1, 0x12345678; \
    li  x2, 0x00000001; \
    mvmn x3, x1, x2; \
  )

  # rs2 is non-zero (negative): keep rd unchanged
  # rd=0x00000000, rs1=0xFFFFFFFF, rs2=0xFFFFFFFF -> result=0x00000000
  TEST_CASE( 4, x3, 0x00000000, \
    li  x3, 0x00000000; \
    li  x1, 0xffffffff; \
    li  x2, 0xffffffff; \
    mvmn x3, x1, x2; \
  )

  # rs2 is non-zero (large): keep rd unchanged
  # rd=0x80000000, rs1=0x7FFFFFFF, rs2=0x7FFFFFFF -> result=0x80000000
  TEST_CASE( 5, x3, 0x80000000, \
    li  x3, 0x80000000; \
    li  x1, 0x7fffffff; \
    li  x2, 0x7fffffff; \
    mvmn x3, x1, x2; \
  )

  # rs2 is zero: move rs1 to rd (rd has different value)
  # rd=0x55555555, rs1=0xAAAAAAAA, rs2=0x00000000 -> result=0xAAAAAAAA
  TEST_CASE( 6, x3, 0xaaaaaaaa, \
    li  x3, 0x55555555; \
    li  x1, 0xaaaaaaaa; \
    li  x2, 0x00000000; \
    mvmn x3, x1, x2; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 7, mvmn, 0x12345678, 0x12345678, 0x00000000 );
  TEST_RR_SRC2_EQ_DEST( 8, mvmn, 0xabcdef00, 0x12345678, 0x00000001 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

