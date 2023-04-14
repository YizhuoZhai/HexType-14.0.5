; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=SSE --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.2 | FileCheck %s --check-prefix=SSE --check-prefix=SSE42
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=AVX --check-prefix=AVX512

; Widened shuffle broadcast loads

define <4 x float> @load_splat_4f32_4f32_0101(<4 x float>* %ptr) nounwind uwtable readnone ssp {
; SSE2-LABEL: load_splat_4f32_4f32_0101:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    movaps (%rdi), %xmm0
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: load_splat_4f32_4f32_0101:
; SSE42:       # %bb.0: # %entry
; SSE42-NEXT:    movddup {{.*#+}} xmm0 = mem[0,0]
; SSE42-NEXT:    retq
;
; AVX-LABEL: load_splat_4f32_4f32_0101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX-NEXT:    retq
entry:
  %ld = load <4 x float>, <4 x float>* %ptr
  %ret = shufflevector <4 x float> %ld, <4 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x float> %ret
}

define <8 x float> @load_splat_8f32_4f32_01010101(<4 x float>* %ptr) nounwind uwtable readnone ssp {
; SSE2-LABEL: load_splat_8f32_4f32_01010101:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    movaps (%rdi), %xmm0
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    retq
;
; SSE42-LABEL: load_splat_8f32_4f32_01010101:
; SSE42:       # %bb.0: # %entry
; SSE42-NEXT:    movddup {{.*#+}} xmm0 = mem[0,0]
; SSE42-NEXT:    movapd %xmm0, %xmm1
; SSE42-NEXT:    retq
;
; AVX-LABEL: load_splat_8f32_4f32_01010101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <4 x float>, <4 x float>* %ptr
  %ret = shufflevector <4 x float> %ld, <4 x float> undef, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x float> %ret
}

define <8 x float> @load_splat_8f32_8f32_01010101(<8 x float>* %ptr) nounwind uwtable readnone ssp {
; SSE2-LABEL: load_splat_8f32_8f32_01010101:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    movaps (%rdi), %xmm0
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    retq
;
; SSE42-LABEL: load_splat_8f32_8f32_01010101:
; SSE42:       # %bb.0: # %entry
; SSE42-NEXT:    movddup {{.*#+}} xmm0 = mem[0,0]
; SSE42-NEXT:    movapd %xmm0, %xmm1
; SSE42-NEXT:    retq
;
; AVX-LABEL: load_splat_8f32_8f32_01010101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <8 x float>, <8 x float>* %ptr
  %ret = shufflevector <8 x float> %ld, <8 x float> undef, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x float> %ret
}

define <4 x i32> @load_splat_4i32_4i32_0101(<4 x i32>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_4i32_4i32_0101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_4i32_4i32_0101:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpermilps {{.*#+}} xmm0 = mem[0,1,0,1]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_4i32_4i32_0101:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_4i32_4i32_0101:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX512-NEXT:    retq
entry:
  %ld = load <4 x i32>, <4 x i32>* %ptr
  %ret = shufflevector <4 x i32> %ld, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x i32> %ret
}

define <8 x i32> @load_splat_8i32_4i32_01010101(<4 x i32>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_8i32_4i32_01010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_8i32_4i32_01010101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <4 x i32>, <4 x i32>* %ptr
  %ret = shufflevector <4 x i32> %ld, <4 x i32> undef, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x i32> %ret
}

define <8 x i32> @load_splat_8i32_8i32_01010101(<8 x i32>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_8i32_8i32_01010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_8i32_8i32_01010101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <8 x i32>, <8 x i32>* %ptr
  %ret = shufflevector <8 x i32> %ld, <8 x i32> undef, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x i32> %ret
}

define <8 x i16> @load_splat_8i16_8i16_01010101(<8 x i16>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_8i16_8i16_01010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,0,0,0]
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_8i16_8i16_01010101:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpermilps {{.*#+}} xmm0 = mem[0,0,0,0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_8i16_8i16_01010101:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vbroadcastss (%rdi), %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_8i16_8i16_01010101:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vbroadcastss (%rdi), %xmm0
; AVX512-NEXT:    retq
entry:
  %ld = load <8 x i16>, <8 x i16>* %ptr
  %ret = shufflevector <8 x i16> %ld, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x i16> %ret
}

define <8 x i16> @load_splat_8i16_8i16_01230123(<8 x i16>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_8i16_8i16_01230123:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_8i16_8i16_01230123:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpermilps {{.*#+}} xmm0 = mem[0,1,0,1]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_8i16_8i16_01230123:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_8i16_8i16_01230123:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX512-NEXT:    retq
entry:
  %ld = load <8 x i16>, <8 x i16>* %ptr
  %ret = shufflevector <8 x i16> %ld, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <8 x i16> %ret
}

define <16 x i16> @load_splat_16i16_8i16_0101010101010101(<8 x i16>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i16_8i16_0101010101010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,0,0,0]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_16i16_8i16_0101010101010101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastss (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <8 x i16>, <8 x i16>* %ptr
  %ret = shufflevector <8 x i16> %ld, <8 x i16> undef, <16 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <16 x i16> %ret
}

define <16 x i16> @load_splat_16i16_8i16_0123012301230123(<8 x i16>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i16_8i16_0123012301230123:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_16i16_8i16_0123012301230123:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <8 x i16>, <8 x i16>* %ptr
  %ret = shufflevector <8 x i16> %ld, <8 x i16> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3,i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i16> %ret
}

define <16 x i16> @load_splat_16i16_16i16_0101010101010101(<16 x i16>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i16_16i16_0101010101010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,0,0,0]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_16i16_16i16_0101010101010101:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastss (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <16 x i16>, <16 x i16>* %ptr
  %ret = shufflevector <16 x i16> %ld, <16 x i16> undef, <16 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <16 x i16> %ret
}

define <16 x i16> @load_splat_16i16_16i16_0123012301230123(<16 x i16>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i16_16i16_0123012301230123:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_16i16_16i16_0123012301230123:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <16 x i16>, <16 x i16>* %ptr
  %ret = shufflevector <16 x i16> %ld, <16 x i16> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3,i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i16> %ret
}

define <16 x i8> @load_splat_16i8_16i8_0101010101010101(<16 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i8_16i8_0101010101010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = mem[0,0,0,0,4,5,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_16i8_16i8_0101010101010101:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = mem[0,0,0,0,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_16i8_16i8_0101010101010101:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vpbroadcastw (%rdi), %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_16i8_16i8_0101010101010101:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vpbroadcastw (%rdi), %xmm0
; AVX512-NEXT:    retq
entry:
  %ld = load <16 x i8>, <16 x i8>* %ptr
  %ret = shufflevector <16 x i8> %ld, <16 x i8> undef, <16 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <16 x i8> %ret
}

define <16 x i8> @load_splat_16i8_16i8_0123012301230123(<16 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i8_16i8_0123012301230123:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,0,0,0]
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_16i8_16i8_0123012301230123:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpermilps {{.*#+}} xmm0 = mem[0,0,0,0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_16i8_16i8_0123012301230123:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vbroadcastss (%rdi), %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_16i8_16i8_0123012301230123:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vbroadcastss (%rdi), %xmm0
; AVX512-NEXT:    retq
entry:
  %ld = load <16 x i8>, <16 x i8>* %ptr
  %ret = shufflevector <16 x i8> %ld, <16 x i8> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %ret
}

define <16 x i8> @load_splat_16i8_16i8_0123456701234567(<16 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_16i8_16i8_0123456701234567:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_16i8_16i8_0123456701234567:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpermilps {{.*#+}} xmm0 = mem[0,1,0,1]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_16i8_16i8_0123456701234567:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_16i8_16i8_0123456701234567:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX512-NEXT:    retq
entry:
  %ld = load <16 x i8>, <16 x i8>* %ptr
  %ret = shufflevector <16 x i8> %ld, <16 x i8> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <16 x i8> %ret
}

define <32 x i8> @load_splat_32i8_16i8_01010101010101010101010101010101(<16 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_32i8_16i8_01010101010101010101010101010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = mem[0,0,0,0,4,5,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_32i8_16i8_01010101010101010101010101010101:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = mem[0,0,0,0,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_32i8_16i8_01010101010101010101010101010101:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vpbroadcastw (%rdi), %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_32i8_16i8_01010101010101010101010101010101:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vpbroadcastw (%rdi), %ymm0
; AVX512-NEXT:    retq
entry:
  %ld = load <16 x i8>, <16 x i8>* %ptr
  %ret = shufflevector <16 x i8> %ld, <16 x i8> undef, <32 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <32 x i8> %ret
}

define <32 x i8> @load_splat_32i8_16i8_01230123012301230123012301230123(<16 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_32i8_16i8_01230123012301230123012301230123:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,0,0,0]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_32i8_16i8_01230123012301230123012301230123:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastss (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <16 x i8>, <16 x i8>* %ptr
  %ret = shufflevector <16 x i8> %ld, <16 x i8> undef, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <32 x i8> %ret
}

define <32 x i8> @load_splat_32i8_16i8_01234567012345670123456701234567(<16 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_32i8_16i8_01234567012345670123456701234567:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_32i8_16i8_01234567012345670123456701234567:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <16 x i8>, <16 x i8>* %ptr
  %ret = shufflevector <16 x i8> %ld, <16 x i8> undef, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <32 x i8> %ret
}

define <32 x i8> @load_splat_32i8_32i8_01010101010101010101010101010101(<32 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_32i8_32i8_01010101010101010101010101010101:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = mem[0,0,0,0,4,5,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_32i8_32i8_01010101010101010101010101010101:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = mem[0,0,0,0,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_32i8_32i8_01010101010101010101010101010101:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vpbroadcastw (%rdi), %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_32i8_32i8_01010101010101010101010101010101:
; AVX512:       # %bb.0: # %entry
; AVX512-NEXT:    vpbroadcastw (%rdi), %ymm0
; AVX512-NEXT:    retq
entry:
  %ld = load <32 x i8>, <32 x i8>* %ptr
  %ret = shufflevector <32 x i8> %ld, <32 x i8> undef, <32 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <32 x i8> %ret
}

define <32 x i8> @load_splat_32i8_32i8_01230123012301230123012301230123(<32 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_32i8_32i8_01230123012301230123012301230123:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,0,0,0]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_32i8_32i8_01230123012301230123012301230123:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastss (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <32 x i8>, <32 x i8>* %ptr
  %ret = shufflevector <32 x i8> %ld, <32 x i8> undef, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  ret <32 x i8> %ret
}

define <32 x i8> @load_splat_32i8_32i8_01234567012345670123456701234567(<32 x i8>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_32i8_32i8_01234567012345670123456701234567:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = mem[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_32i8_32i8_01234567012345670123456701234567:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <32 x i8>, <32 x i8>* %ptr
  %ret = shufflevector <32 x i8> %ld, <32 x i8> undef, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <32 x i8> %ret
}

define <4 x float> @load_splat_4f32_8f32_0000(<8 x float>* %ptr) nounwind uwtable readnone ssp {
; SSE-LABEL: load_splat_4f32_8f32_0000:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_4f32_8f32_0000:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastss (%rdi), %xmm0
; AVX-NEXT:    retq
entry:
  %ld = load <8 x float>, <8 x float>* %ptr
  %ret = shufflevector <8 x float> %ld, <8 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %ret
}

define <8 x float> @load_splat_8f32_16f32_89898989(<16 x float>* %ptr) nounwind uwtable readnone ssp {
; SSE2-LABEL: load_splat_8f32_16f32_89898989:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    movaps 32(%rdi), %xmm0
; SSE2-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0,0]
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    retq
;
; SSE42-LABEL: load_splat_8f32_16f32_89898989:
; SSE42:       # %bb.0: # %entry
; SSE42-NEXT:    movddup {{.*#+}} xmm0 = mem[0,0]
; SSE42-NEXT:    movapd %xmm0, %xmm1
; SSE42-NEXT:    retq
;
; AVX-LABEL: load_splat_8f32_16f32_89898989:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vbroadcastsd 32(%rdi), %ymm0
; AVX-NEXT:    retq
entry:
  %ld = load <16 x float>, <16 x float>* %ptr
  %ret = shufflevector <16 x float> %ld, <16 x float> undef, <8 x i32> <i32 8, i32 9, i32 8, i32 9, i32 8, i32 9, i32 8, i32 9>
  ret <8 x float> %ret
}

; PR34394
define <4 x i32> @load_splat_4i32_2i32_0101(<2 x i32>* %vp) {
; SSE-LABEL: load_splat_4i32_2i32_0101:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_4i32_2i32_0101:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovddup {{.*#+}} xmm0 = mem[0,0]
; AVX-NEXT:    retq
  %vec = load <2 x i32>, <2 x i32>* %vp
  %res = shufflevector <2 x i32> %vec, <2 x i32> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x i32> %res
}

define <8 x i32> @load_splat_8i32_2i32_0101(<2 x i32>* %vp) {
; SSE-LABEL: load_splat_8i32_2i32_0101:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: load_splat_8i32_2i32_0101:
; AVX:       # %bb.0:
; AVX-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX-NEXT:    retq
  %vec = load <2 x i32>, <2 x i32>* %vp
  %res = shufflevector <2 x i32> %vec, <2 x i32> undef, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x i32> %res
}

define <16 x i32> @load_splat_16i32_2i32_0101(<2 x i32>* %vp) {
; SSE-LABEL: load_splat_16i32_2i32_0101:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    movdqa %xmm0, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_splat_16i32_2i32_0101:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX1-NEXT:    vmovaps %ymm0, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_splat_16i32_2i32_0101:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastsd (%rdi), %ymm0
; AVX2-NEXT:    vmovaps %ymm0, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_splat_16i32_2i32_0101:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vbroadcastsd (%rdi), %zmm0
; AVX512-NEXT:    retq
  %vec = load <2 x i32>, <2 x i32>* %vp
  %res = shufflevector <2 x i32> %vec, <2 x i32> undef, <16 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <16 x i32> %res
}
