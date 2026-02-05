# See LICENSE for license details.

#*****************************************************************************
# merge.S
#-----------------------------------------------------------------------------
#
# Test merge instruction.
# rd = (rs2 & rd) | (rs1 & ~rs2)
# Uses rs2 as a mask to select between rs1 and rd.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Basic merge: rs2=0xFFFFFFFF selects all from rd
  # rd=0x12345678, rs1=0xABCDEF00, rs2=0xFFFFFFFF -> result=0x12345678
  TEST_CASE( 2, x3, 0x12345678, \
    li  x3, 0x12345678; \
    li  x1, 0xabcdef00; \
    li  x2, 0xffffffff; \
    merge x3, x1, x2; \
  )

  # Merge with zero mask: rs2=0x00000000 selects all from rs1
  # rd=0x12345678, rs1=0xABCDEF00, rs2=0x00000000 -> result=0xABCDEF00
  TEST_CASE( 3, x3, 0xabcdef00, \
    li  x3, 0x12345678; \
    li  x1, 0xabcdef00; \
    li  x2, 0x00000000; \
    merge x3, x1, x2; \
  )

  # Merge with alternating mask: rs2=0xAAAAAAAA
  # rd=0x55555555, rs1=0xFFFFFFFF, rs2=0xAAAAAAAA -> result=0xFFFFFFFF
  TEST_CASE( 4, x3, 0xffffffff, \
    li  x3, 0x55555555; \
    li  x1, 0xffffffff; \
    li  x2, 0xaaaaaaaa; \
    merge x3, x1, x2; \
  )

  # Merge with alternating mask: rs2=0x55555555
  # rd=0xFFFFFFFF, rs1=0x00000000, rs2=0x55555555 -> result=0xAAAAAAAA
  TEST_CASE( 5, x3, 0xaaaaaaaa, \
    li  x3, 0xffffffff; \
    li  x1, 0x00000000; \
    li  x2, 0x55555555; \
    merge x3, x1, x2; \
  )

  # Merge with partial mask: rs2=0x0000FFFF
  # rd=0xFFFF0000, rs1=0x0000FFFF, rs2=0x0000FFFF -> result=0xFFFFFFFF
  TEST_CASE( 6, x3, 0xffffffff, \
    li  x3, 0xffff0000; \
    li  x1, 0x0000ffff; \
    li  x2, 0x0000ffff; \
    merge x3, x1, x2; \
  )

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 7, merge, 0xffffffff, 0xffffffff, 0xffffffff );
  TEST_RR_SRC2_EQ_DEST( 8, merge, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

