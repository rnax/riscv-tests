# See LICENSE for license details.

#*****************************************************************************
# pssha_dhs_p0.S
#-----------------------------------------------------------------------------
#
# Test pssha.dhs zero-pair constraint (rd_p=0 suppresses write; rs1_p=0 reads as 0).
# rs2 is a scalar register, so Pattern C (rs2_p=0) does not apply.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Zero-pair constraint tests
  #-------------------------------------------------------------

  # pssha.dhs rd_pair, rs1_pair, rs2_scalar
  # Packed saturating shift halfword (double-word, scalar shift amount).
  # rd and rs1 must be even registers (register-pair constraint).
  # rs2 is a single (scalar) register: not a pair.
  # Pair index 0 (x0/x1): writes suppressed; source reads as 0.

  # Pattern A: rd_p=0, destination write suppressed.
  # Pre-load x1=0xdeadbeef; execute pssha.dhs x0, x10, x12 (rd=x0 -> pair 0).
  # x1 must still be 0xdeadbeef.
  TEST_CASE( 2, x1, 0xdeadbeef, \
    TEST_VXSAT_CLEAR; \
    li x1, 0xdeadbeef; \
    li x10, 0x00010002; \
    li x11, 0x00010002; \
    li x12, 1; \
    pssha.dhs x0, x10, x12 );

  # Pattern B: rs1_p=0, source reads as 0 pair.
  # pssha.dhs(0, shift) = saturating_shift(0, shift) = 0 for any shift.
  # x14 (low)  = 0x00000000
  # x15 (high) = 0x00000000
  TEST_CASE( 3, x14, 0x00000000, \
    TEST_VXSAT_CLEAR; \
    li x1, 0xdeadbeef; \
    li x12, 1; \
    pssha.dhs x14, x0, x12 );
  TEST_CASE( 4, x15, 0x00000000, nop );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
