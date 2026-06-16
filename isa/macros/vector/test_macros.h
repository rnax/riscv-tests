// See LICENSE for license details.

#ifndef __TEST_MACROS_VECTOR_H
#define __TEST_MACROS_VECTOR_H

//-----------------------------------------------------------------------
// Helper constants — RISC-V rounding modes
//-----------------------------------------------------------------------
#define RM_RNE 0
#define RM_RTZ 1
#define RM_RDN 2
#define RM_RUP 3
#define RM_RMM 4

//-----------------------------------------------------------------------
// vtype encodings used by Zvfofp8min tests.
// Layout: altfmt[8] | vma[7] | vta[6] | vsew[5:3] | vlmul[2:0]
//-----------------------------------------------------------------------
// SEW=8, LMUL=1, VTA=1, VMA=1, altfmt=0
#define VTYPE_E8M1     0xC0
// SEW=8, LMUL=1, VTA=1, VMA=1, altfmt=1
#define VTYPE_E8M1_ALT 0x1C0
// SEW=16, LMUL=1, VTA=1, VMA=1, altfmt=0
#define VTYPE_E16M1    0xC8
// SEW=32, LMUL=1, VTA=1, VMA=1, altfmt=0
#define VTYPE_E32M1    0xD0

//-----------------------------------------------------------------------
// Internal: widening OFP8->BF16 (vfwcvtbf16.f.f.v with SEW=8 + altfmt).
// No rounding, no fflags. altfmt selects e4m3 (0) vs e5m2 (1).
//-----------------------------------------------------------------------
#define TEST_VFWCVTBF16_F_F_V_OFP8(testnum, altfmt, src_ofp8, expected_bf16) \
test_ ## testnum: ; \
  li      TESTNUM, testnum; \
  la      a0, test_ ## testnum ## _data; \
  li      t0, VTYPE_E8M1 | ((altfmt) << 8); \
  li      t1, 1; \
  vsetvl  x0, t1, t0; \
  vle8.v  v8, (a0); \
  vfwcvtbf16.f.f.v v2, v8; \
  /* switch to SEW=16, store BF16 result to data block, lhu it back */ \
  li      t0, VTYPE_E16M1; \
  vsetvl  x0, t1, t0; \
  vse16.v v2, (a0); \
  lhu     t2, 0(a0); \
  li      t3, (expected_bf16) & 0xFFFF; \
  bne     t2, t3, fail; \
  .pushsection .data; \
  .align  1; \
  test_ ## testnum ## _data: ; \
  .half   (src_ofp8) & 0xFF; \
  .popsection

//-----------------------------------------------------------------------
// Internal: narrowing FP32->OFP8 (vfncvt.f.f.q / vfncvt.sat.f.f.q).
// Load src as FP32 (SEW=32), then op at SEW=8+altfmt. Compare result + fflags.
//-----------------------------------------------------------------------
#define TEST_ZVFOFP8_NARROW_FP32_INTERNAL(testnum, op_inst, frm_v, altfmt, src_fp32, expected_ofp8, expected_fflags) \
test_ ## testnum: ; \
  li      TESTNUM, testnum; \
  la      a0, test_ ## testnum ## _data; \
  li      t0, VTYPE_E32M1; \
  li      t1, 1; \
  vsetvl  x0, t1, t0; \
  vle32.v v8, (a0); \
  li      t2, (frm_v); \
  csrw    frm, t2; \
  csrwi   fflags, 0; \
  li      t0, VTYPE_E8M1 | ((altfmt) << 8); \
  vsetvl  x0, t1, t0; \
  op_inst v2, v8; \
  vmv.x.s t2, v2; \
  andi    t2, t2, 0xFF; \
  li      t3, (expected_ofp8) & 0xFF; \
  bne     t2, t3, fail; \
  csrr    t2, fflags; \
  andi    t2, t2, 0x1F; \
  li      t3, (expected_fflags) & 0x1F; \
  bne     t2, t3, fail; \
  .pushsection .data; \
  .align  2; \
  test_ ## testnum ## _data: ; \
  .word   (src_fp32); \
  .popsection

#define TEST_VFNCVT_F_F_Q(testnum, frm_v, altfmt, src_fp32, expected_ofp8, expected_fflags) \
  TEST_ZVFOFP8_NARROW_FP32_INTERNAL(testnum, vfncvt.f.f.q, frm_v, altfmt, src_fp32, expected_ofp8, expected_fflags)

#define TEST_VFNCVT_SAT_F_F_Q(testnum, frm_v, altfmt, src_fp32, expected_ofp8, expected_fflags) \
  TEST_ZVFOFP8_NARROW_FP32_INTERNAL(testnum, vfncvt.sat.f.f.q, frm_v, altfmt, src_fp32, expected_ofp8, expected_fflags)

//-----------------------------------------------------------------------
// Internal: narrowing BF16->OFP8 (vfncvtbf16.f.f.w / vfncvtbf16.sat.f.f.w).
// Load src as BF16 (SEW=16), then op at SEW=8+altfmt.
//-----------------------------------------------------------------------
#define TEST_ZVFOFP8_NARROW_BF16_INTERNAL(testnum, op_inst, frm_v, altfmt, src_bf16, expected_ofp8, expected_fflags) \
test_ ## testnum: ; \
  li      TESTNUM, testnum; \
  la      a0, test_ ## testnum ## _data; \
  li      t0, VTYPE_E16M1; \
  li      t1, 1; \
  vsetvl  x0, t1, t0; \
  vle16.v v8, (a0); \
  li      t2, (frm_v); \
  csrw    frm, t2; \
  csrwi   fflags, 0; \
  li      t0, VTYPE_E8M1 | ((altfmt) << 8); \
  vsetvl  x0, t1, t0; \
  op_inst v2, v8; \
  vmv.x.s t2, v2; \
  andi    t2, t2, 0xFF; \
  li      t3, (expected_ofp8) & 0xFF; \
  bne     t2, t3, fail; \
  csrr    t2, fflags; \
  andi    t2, t2, 0x1F; \
  li      t3, (expected_fflags) & 0x1F; \
  bne     t2, t3, fail; \
  .pushsection .data; \
  .align  1; \
  test_ ## testnum ## _data: ; \
  .half   (src_bf16); \
  .popsection

#define TEST_VFNCVTBF16_F_F_W(testnum, frm_v, altfmt, src_bf16, expected_ofp8, expected_fflags) \
  TEST_ZVFOFP8_NARROW_BF16_INTERNAL(testnum, vfncvtbf16.f.f.w, frm_v, altfmt, src_bf16, expected_ofp8, expected_fflags)

#define TEST_VFNCVTBF16_SAT_F_F_W(testnum, frm_v, altfmt, src_bf16, expected_ofp8, expected_fflags) \
  TEST_ZVFOFP8_NARROW_BF16_INTERNAL(testnum, vfncvtbf16.sat.f.f.w, frm_v, altfmt, src_bf16, expected_ofp8, expected_fflags)

#endif // __TEST_MACROS_VECTOR_H
