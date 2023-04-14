; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN:  llc -amdgpu-scalarize-global-loads=false  -march=amdgcn -mtriple=amdgcn-- -mcpu=verde -verify-machineinstrs < %s | FileCheck %s -check-prefixes=SI
; RUN:  llc -amdgpu-scalarize-global-loads=false  -march=amdgcn -mtriple=amdgcn-- -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck %s -check-prefixes=VI
; RUN:  llc -amdgpu-scalarize-global-loads=false  -march=r600 -mtriple=r600-- -mcpu=redwood -verify-machineinstrs < %s | FileCheck %s -check-prefixes=EG

declare i32 @llvm.amdgcn.workitem.id.x() #0

define amdgpu_kernel void @ashr_v2i32(<2 x i32> addrspace(1)* %out, <2 x i32> addrspace(1)* %in) {
; SI-LABEL: ashr_v2i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashr_i32_e32 v1, v1, v3
; SI-NEXT:    v_ashr_i32_e32 v0, v0, v2
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v2i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_e32 v1, v3, v1
; VI-NEXT:    v_ashrrev_i32_e32 v0, v2, v0
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_v2i32:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 3, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     ASHR * T0.Y, T0.Y, T0.W,
; EG-NEXT:     ASHR T0.X, T0.X, T0.Z,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %b_ptr = getelementptr <2 x i32>, <2 x i32> addrspace(1)* %in, i32 1
  %a = load <2 x i32>, <2 x i32> addrspace(1)* %in
  %b = load <2 x i32>, <2 x i32> addrspace(1)* %b_ptr
  %result = ashr <2 x i32> %a, %b
  store <2 x i32> %result, <2 x i32> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @ashr_v4i32(<4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)* %in) {
; SI-LABEL: ashr_v4i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; SI-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashr_i32_e32 v3, v3, v7
; SI-NEXT:    v_ashr_i32_e32 v2, v2, v6
; SI-NEXT:    v_ashr_i32_e32 v1, v1, v5
; SI-NEXT:    v_ashr_i32_e32 v0, v0, v4
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v4i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; VI-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_e32 v3, v7, v3
; VI-NEXT:    v_ashrrev_i32_e32 v2, v6, v2
; VI-NEXT:    v_ashrrev_i32_e32 v1, v5, v1
; VI-NEXT:    v_ashrrev_i32_e32 v0, v4, v0
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_v4i32:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @10, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 1 @6
; EG-NEXT:    ALU 5, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 16, #1
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 10:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     ASHR * T0.W, T0.W, T1.W,
; EG-NEXT:     ASHR * T0.Z, T0.Z, T1.Z,
; EG-NEXT:     ASHR * T0.Y, T0.Y, T1.Y,
; EG-NEXT:     ASHR T0.X, T0.X, T1.X,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %b_ptr = getelementptr <4 x i32>, <4 x i32> addrspace(1)* %in, i32 1
  %a = load <4 x i32>, <4 x i32> addrspace(1)* %in
  %b = load <4 x i32>, <4 x i32> addrspace(1)* %b_ptr
  %result = ashr <4 x i32> %a, %b
  store <4 x i32> %result, <4 x i32> addrspace(1)* %out
  ret void
}

; FIXME: The ashr operation is uniform, but because its operands come from a
; global load we end up with the vector instructions rather than scalar.
define amdgpu_kernel void @ashr_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in) {
; SI-LABEL: ashr_v2i16:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx2 v[0:1], off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_bfe_i32 v2, v0, 0, 16
; SI-NEXT:    v_ashrrev_i32_e32 v0, 16, v0
; SI-NEXT:    v_lshrrev_b32_e32 v3, 16, v1
; SI-NEXT:    v_ashrrev_i32_e32 v0, v3, v0
; SI-NEXT:    v_ashrrev_i32_e32 v1, v1, v2
; SI-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; SI-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; SI-NEXT:    v_or_b32_e32 v0, v1, v0
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx2 v[0:1], off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_sdwa v2, sext(v1), sext(v0) dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:WORD_0
; VI-NEXT:    v_ashrrev_i32_sdwa v0, sext(v1), sext(v0) dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_sdwa v0, v2, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_v2i16:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 14, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T6.X, T7.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_64 T6.XY, T6.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T6.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T0.W, T6.X, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     BFE_INT T0.Y, PV.W, 0.0, literal.x,
; EG-NEXT:     LSHR T0.Z, T6.Y, literal.x,
; EG-NEXT:     BFE_INT T0.W, T6.X, 0.0, literal.x,
; EG-NEXT:     AND_INT * T1.W, T6.Y, literal.y,
; EG-NEXT:    16(2.242078e-44), 65535(9.183409e-41)
; EG-NEXT:     ASHR T0.W, PV.W, PS,
; EG-NEXT:     ASHR * T1.W, PV.Y, PV.Z,
; EG-NEXT:     LSHL T1.W, PS, literal.x,
; EG-NEXT:     AND_INT * T0.W, PV.W, literal.y,
; EG-NEXT:    16(2.242078e-44), 65535(9.183409e-41)
; EG-NEXT:     OR_INT T6.X, PS, PV.W,
; EG-NEXT:     LSHR * T7.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %b_ptr = getelementptr <2 x i16>, <2 x i16> addrspace(1)* %in, i16 1
  %a = load <2 x i16>, <2 x i16> addrspace(1)* %in
  %b = load <2 x i16>, <2 x i16> addrspace(1)* %b_ptr
  %result = ashr <2 x i16> %a, %b
  store <2 x i16> %result, <2 x i16> addrspace(1)* %out
  ret void
}

; FIXME: The ashr operation is uniform, but because its operands come from a
; global load we end up with the vector instructions rather than scalar.
define amdgpu_kernel void @ashr_v4i16(<4 x i16> addrspace(1)* %out, <4 x i16> addrspace(1)* %in) {
; SI-LABEL: ashr_v4i16:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s2, 0xffff
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_bfe_i32 v4, v0, 0, 16
; SI-NEXT:    v_ashrrev_i32_e32 v0, 16, v0
; SI-NEXT:    v_bfe_i32 v5, v1, 0, 16
; SI-NEXT:    v_ashrrev_i32_e32 v1, 16, v1
; SI-NEXT:    v_lshrrev_b32_e32 v6, 16, v2
; SI-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; SI-NEXT:    v_ashr_i32_e32 v1, v1, v7
; SI-NEXT:    v_ashr_i32_e32 v3, v5, v3
; SI-NEXT:    v_ashr_i32_e32 v0, v0, v6
; SI-NEXT:    v_ashr_i32_e32 v2, v4, v2
; SI-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; SI-NEXT:    v_and_b32_e32 v3, s2, v3
; SI-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; SI-NEXT:    v_and_b32_e32 v2, s2, v2
; SI-NEXT:    v_or_b32_e32 v1, v3, v1
; SI-NEXT:    v_or_b32_e32 v0, v2, v0
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v4i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_sdwa v4, sext(v2), sext(v0) dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:WORD_0
; VI-NEXT:    v_ashrrev_i32_sdwa v0, sext(v2), sext(v0) dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_ashrrev_i32_sdwa v2, sext(v3), sext(v1) dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:WORD_0
; VI-NEXT:    v_ashrrev_i32_sdwa v1, sext(v3), sext(v1) dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_sdwa v1, v2, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; VI-NEXT:    v_or_b32_sdwa v0, v4, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_v4i16:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 58, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T10.XY, T9.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T9.XYZW, T9.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T9.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     MOV T4.X, T9.X,
; EG-NEXT:     MOV * T5.X, T9.Y,
; EG-NEXT:     MOV T0.Y, PV.X,
; EG-NEXT:     MOV * T0.Z, PS,
; EG-NEXT:     MOV T2.X, T9.Z,
; EG-NEXT:     MOV * T3.X, T9.W,
; EG-NEXT:     MOV * T0.W, T6.X,
; EG-NEXT:     MOV T1.Y, T2.X,
; EG-NEXT:     BFE_INT * T1.W, T0.Y, 0.0, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     AND_INT * T2.W, PV.Y, literal.x,
; EG-NEXT:    65535(9.183409e-41), 0(0.000000e+00)
; EG-NEXT:     ASHR * T1.W, T1.W, PV.W,
; EG-NEXT:     AND_INT T1.W, PV.W, literal.x,
; EG-NEXT:     AND_INT * T0.W, T0.W, literal.y,
; EG-NEXT:    65535(9.183409e-41), -65536(nan)
; EG-NEXT:     OR_INT * T0.W, PS, PV.W,
; EG-NEXT:     MOV * T1.Z, T3.X,
; EG-NEXT:     MOV * T6.X, T0.W,
; EG-NEXT:     MOV T0.W, PV.X,
; EG-NEXT:     LSHR * T1.W, T0.Y, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     BFE_INT T1.W, PS, 0.0, literal.x,
; EG-NEXT:     LSHR * T2.W, T1.Y, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     ASHR T1.W, PV.W, PS,
; EG-NEXT:     AND_INT * T0.W, T0.W, literal.x,
; EG-NEXT:    65535(9.183409e-41), 0(0.000000e+00)
; EG-NEXT:     LSHL * T1.W, PV.W, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     OR_INT * T0.W, T0.W, PV.W,
; EG-NEXT:     MOV T6.X, PV.W,
; EG-NEXT:     MOV T0.Y, T7.X,
; EG-NEXT:     BFE_INT T0.W, T0.Z, 0.0, literal.x,
; EG-NEXT:     AND_INT * T1.W, T1.Z, literal.y,
; EG-NEXT:    16(2.242078e-44), 65535(9.183409e-41)
; EG-NEXT:     ASHR T0.W, PV.W, PS,
; EG-NEXT:     AND_INT * T1.W, PV.Y, literal.x,
; EG-NEXT:    -65536(nan), 0(0.000000e+00)
; EG-NEXT:     AND_INT * T0.W, PV.W, literal.x,
; EG-NEXT:    65535(9.183409e-41), 0(0.000000e+00)
; EG-NEXT:     OR_INT * T0.W, T1.W, PV.W,
; EG-NEXT:     MOV * T7.X, PV.W,
; EG-NEXT:     MOV T0.Y, PV.X,
; EG-NEXT:     LSHR * T0.W, T0.Z, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     BFE_INT T0.W, PV.W, 0.0, literal.x,
; EG-NEXT:     LSHR * T1.W, T1.Z, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     ASHR T0.W, PV.W, PS,
; EG-NEXT:     AND_INT * T1.W, T0.Y, literal.x,
; EG-NEXT:    65535(9.183409e-41), 0(0.000000e+00)
; EG-NEXT:     LSHL * T0.W, PV.W, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR T9.X, KC0[2].Y, literal.x,
; EG-NEXT:     OR_INT * T10.Y, T1.W, PV.W,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:     MOV T7.X, PV.Y,
; EG-NEXT:     MOV * T10.X, T6.X,
  %b_ptr = getelementptr <4 x i16>, <4 x i16> addrspace(1)* %in, i16 1
  %a = load <4 x i16>, <4 x i16> addrspace(1)* %in
  %b = load <4 x i16>, <4 x i16> addrspace(1)* %b_ptr
  %result = ashr <4 x i16> %a, %b
  store <4 x i16> %result, <4 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_ashr_i64(i64 addrspace(1)* %out, i32 %in) {
; SI-LABEL: s_ashr_i64:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    s_load_dword s4, s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_ashr_i32 s5, s4, 31
; SI-NEXT:    s_ashr_i64 s[4:5], s[4:5], 8
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_ashr_i64:
; VI:       ; %bb.0: ; %entry
; VI-NEXT:    s_load_dword s4, s[0:1], 0x2c
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_ashr_i32 s5, s4, 31
; VI-NEXT:    s_ashr_i64 s[4:5], s[4:5], 8
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: s_ashr_i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 4, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     ASHR * T0.Y, KC0[2].Z, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     BIT_ALIGN_INT T0.X, PV.Y, KC0[2].Z, literal.x,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; EG-NEXT:    8(1.121039e-44), 2(2.802597e-45)
entry:
  %in.ext = sext i32 %in to i64
  %ashr = ashr i64 %in.ext, 8
  store i64 %ashr, i64 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @ashr_i64_2(i64 addrspace(1)* %out, i64 addrspace(1)* %in) {
; SI-LABEL: ashr_i64_2:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashr_i64 v[0:1], v[0:1], v2
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_i64_2:
; VI:       ; %bb.0: ; %entry
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i64 v[0:1], v2, v[0:1]
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_i64_2:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 10, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     AND_INT * T0.W, T0.Z, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     ASHR T1.Z, T0.Y, PV.W,
; EG-NEXT:     BIT_ALIGN_INT T0.W, T0.Y, T0.X, T0.Z,
; EG-NEXT:     AND_INT * T1.W, T0.Z, literal.x,
; EG-NEXT:    32(4.484155e-44), 0(0.000000e+00)
; EG-NEXT:     CNDE_INT T0.X, PS, PV.W, PV.Z,
; EG-NEXT:     ASHR T0.W, T0.Y, literal.x,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; EG-NEXT:    31(4.344025e-44), 2(2.802597e-45)
; EG-NEXT:     CNDE_INT * T0.Y, T1.W, T1.Z, PV.W,
entry:
  %b_ptr = getelementptr i64, i64 addrspace(1)* %in, i64 1
  %a = load i64, i64 addrspace(1)* %in
  %b = load i64, i64 addrspace(1)* %b_ptr
  %result = ashr i64 %a, %b
  store i64 %result, i64 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @ashr_v2i64(<2 x i64> addrspace(1)* %out, <2 x i64> addrspace(1)* %in) {
; SI-LABEL: ashr_v2i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; SI-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashr_i64 v[2:3], v[2:3], v6
; SI-NEXT:    v_ashr_i64 v[0:1], v[0:1], v4
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v2i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0
; VI-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i64 v[2:3], v6, v[2:3]
; VI-NEXT:    v_ashrrev_i64 v[0:1], v4, v[0:1]
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_v2i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @10, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 1 @6
; EG-NEXT:    ALU 19, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 16, #1
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 10:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     AND_INT * T1.W, T1.Z, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     ASHR T1.Y, T0.W, PV.W,
; EG-NEXT:     AND_INT T2.Z, T1.Z, literal.x,
; EG-NEXT:     BIT_ALIGN_INT T1.W, T0.W, T0.Z, T1.Z,
; EG-NEXT:     AND_INT * T2.W, T1.X, literal.y,
; EG-NEXT:    32(4.484155e-44), 31(4.344025e-44)
; EG-NEXT:     ASHR T2.Y, T0.Y, PS,
; EG-NEXT:     CNDE_INT T0.Z, PV.Z, PV.W, PV.Y,
; EG-NEXT:     BIT_ALIGN_INT T1.W, T0.Y, T0.X, T1.X,
; EG-NEXT:     AND_INT * T2.W, T1.X, literal.x,
; EG-NEXT:    32(4.484155e-44), 0(0.000000e+00)
; EG-NEXT:     CNDE_INT T0.X, PS, PV.W, PV.Y,
; EG-NEXT:     ASHR T0.W, T0.W, literal.x,
; EG-NEXT:     ASHR * T1.W, T0.Y, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     CNDE_INT * T0.W, T2.Z, T1.Y, PV.W,
; EG-NEXT:     LSHR T1.X, KC0[2].Y, literal.x,
; EG-NEXT:     CNDE_INT * T0.Y, T2.W, T2.Y, T1.W,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %b_ptr = getelementptr <2 x i64>, <2 x i64> addrspace(1)* %in, i64 1
  %a = load <2 x i64>, <2 x i64> addrspace(1)* %in
  %b = load <2 x i64>, <2 x i64> addrspace(1)* %b_ptr
  %result = ashr <2 x i64> %a, %b
  store <2 x i64> %result, <2 x i64> addrspace(1)* %out
  ret void
}

; FIXME: Broken on r600
define amdgpu_kernel void @ashr_v4i64(<4 x i64> addrspace(1)* %out, <4 x i64> addrspace(1)* %in) {
; SI-LABEL: ashr_v4i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s10, s2
; SI-NEXT:    s_mov_b32 s11, s3
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s6
; SI-NEXT:    s_mov_b32 s9, s7
; SI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0 offset:16
; SI-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:48
; SI-NEXT:    buffer_load_dwordx4 v[7:10], off, s[8:11], 0
; SI-NEXT:    buffer_load_dwordx4 v[11:14], off, s[8:11], 0 offset:32
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    s_waitcnt vmcnt(2)
; SI-NEXT:    v_ashr_i64 v[2:3], v[2:3], v6
; SI-NEXT:    v_ashr_i64 v[0:1], v[0:1], v4
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashr_i64 v[9:10], v[9:10], v13
; SI-NEXT:    v_ashr_i64 v[7:8], v[7:8], v11
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0 offset:16
; SI-NEXT:    buffer_store_dwordx4 v[7:10], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ashr_v4i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_mov_b32 s10, s2
; VI-NEXT:    s_mov_b32 s11, s3
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s6
; VI-NEXT:    s_mov_b32 s9, s7
; VI-NEXT:    buffer_load_dwordx4 v[0:3], off, s[8:11], 0 offset:16
; VI-NEXT:    buffer_load_dwordx4 v[4:7], off, s[8:11], 0 offset:48
; VI-NEXT:    buffer_load_dwordx4 v[7:10], off, s[8:11], 0
; VI-NEXT:    buffer_load_dwordx4 v[11:14], off, s[8:11], 0 offset:32
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(2)
; VI-NEXT:    v_ashrrev_i64 v[2:3], v6, v[2:3]
; VI-NEXT:    v_ashrrev_i64 v[0:1], v4, v[0:1]
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i64 v[9:10], v13, v[9:10]
; VI-NEXT:    v_ashrrev_i64 v[7:8], v11, v[7:8]
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0 offset:16
; VI-NEXT:    buffer_store_dwordx4 v[7:10], off, s[0:3], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: ashr_v4i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @14, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 3 @6
; EG-NEXT:    ALU 39, @15, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T2.XYZW, T3.X, 0
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 32, #1
; EG-NEXT:     VTX_READ_128 T2.XYZW, T0.X, 48, #1
; EG-NEXT:     VTX_READ_128 T3.XYZW, T0.X, 0, #1
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 16, #1
; EG-NEXT:    ALU clause starting at 14:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 15:
; EG-NEXT:     AND_INT * T1.W, T1.Z, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     ASHR T1.Y, T0.W, literal.x,
; EG-NEXT:     ASHR T4.Z, T3.W, PV.W, BS:VEC_120/SCL_212
; EG-NEXT:     AND_INT T1.W, T1.Z, literal.y,
; EG-NEXT:     AND_INT * T2.W, T2.Z, literal.x,
; EG-NEXT:    31(4.344025e-44), 32(4.484155e-44)
; EG-NEXT:     BIT_ALIGN_INT T4.X, T3.W, T3.Z, T1.Z,
; EG-NEXT:     ASHR T2.Y, T0.W, PS, BS:VEC_120/SCL_212
; EG-NEXT:     AND_INT * T1.Z, T2.Z, literal.x,
; EG-NEXT:    32(4.484155e-44), 0(0.000000e+00)
; EG-NEXT:     BIT_ALIGN_INT T0.W, T0.W, T0.Z, T2.Z,
; EG-NEXT:     AND_INT * T2.W, T2.X, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     AND_INT T5.X, T1.X, literal.x,
; EG-NEXT:     ASHR T4.Y, T0.Y, PS,
; EG-NEXT:     CNDE_INT T0.Z, T1.Z, PV.W, T2.Y,
; EG-NEXT:     BIT_ALIGN_INT T0.W, T0.Y, T0.X, T2.X,
; EG-NEXT:     AND_INT * T2.W, T2.X, literal.y,
; EG-NEXT:    31(4.344025e-44), 32(4.484155e-44)
; EG-NEXT:     CNDE_INT T0.X, PS, PV.W, PV.Y,
; EG-NEXT:     ASHR T5.Y, T3.Y, PV.X,
; EG-NEXT:     CNDE_INT T2.Z, T1.W, T4.X, T4.Z,
; EG-NEXT:     BIT_ALIGN_INT T0.W, T3.Y, T3.X, T1.X, BS:VEC_102/SCL_221
; EG-NEXT:     AND_INT * T4.W, T1.X, literal.x,
; EG-NEXT:    32(4.484155e-44), 0(0.000000e+00)
; EG-NEXT:     CNDE_INT T2.X, PS, PV.W, PV.Y,
; EG-NEXT:     ASHR T6.Y, T3.W, literal.x,
; EG-NEXT:     ASHR T3.Z, T0.Y, literal.x, BS:VEC_201
; EG-NEXT:     ADD_INT T3.W, KC0[2].Y, literal.y,
; EG-NEXT:     CNDE_INT * T0.W, T1.Z, T2.Y, T1.Y,
; EG-NEXT:    31(4.344025e-44), 16(2.242078e-44)
; EG-NEXT:     LSHR T1.X, PV.W, literal.x,
; EG-NEXT:     CNDE_INT T0.Y, T2.W, T4.Y, PV.Z,
; EG-NEXT:     ASHR T3.W, T3.Y, literal.y,
; EG-NEXT:     CNDE_INT * T2.W, T1.W, T4.Z, PV.Y,
; EG-NEXT:    2(2.802597e-45), 31(4.344025e-44)
; EG-NEXT:     LSHR T3.X, KC0[2].Y, literal.x,
; EG-NEXT:     CNDE_INT * T2.Y, T4.W, T5.Y, PV.W,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %b_ptr = getelementptr <4 x i64>, <4 x i64> addrspace(1)* %in, i64 1
  %a = load <4 x i64>, <4 x i64> addrspace(1)* %in
  %b = load <4 x i64>, <4 x i64> addrspace(1)* %b_ptr
  %result = ashr <4 x i64> %a, %b
  store <4 x i64> %result, <4 x i64> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_ashr_32_i64(i64 addrspace(1)* %out, [8 x i32], i64 %a, [8 x i32], i64 %b) {
; SI-LABEL: s_ashr_32_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s6, s[0:1], 0x14
; SI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x1d
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_ashr_i32 s7, s6, 31
; SI-NEXT:    s_add_u32 s4, s6, s4
; SI-NEXT:    s_addc_u32 s5, s7, s5
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_ashr_32_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s6, s[0:1], 0x50
; VI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x74
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_ashr_i32 s7, s6, 31
; VI-NEXT:    s_add_u32 s4, s6, s4
; VI-NEXT:    s_addc_u32 s5, s7, s5
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: s_ashr_32_i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 7, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     ASHR * T0.W, KC0[5].X, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     ADD_INT * T0.W, PV.W, KC0[7].Z,
; EG-NEXT:     ADDC_UINT * T1.W, KC0[5].X, KC0[7].Y,
; EG-NEXT:     ADD_INT * T0.Y, T0.W, PV.W,
; EG-NEXT:     ADD_INT * T0.X, KC0[5].X, KC0[7].Y,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %result = ashr i64 %a, 32
  %add = add i64 %result, %b
  store i64 %add, i64 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_ashr_32_i64(i64 addrspace(1)* %out, i64 addrspace(1)* %in) {
; SI-LABEL: v_ashr_32_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    s_mov_b64 s[10:11], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 offset:4
; SI-NEXT:    s_mov_b64 s[4:5], s[0:1]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashrrev_i32_e32 v3, 31, v2
; SI-NEXT:    buffer_store_dwordx2 v[2:3], v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_ashr_32_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s3
; VI-NEXT:    v_add_u32_e32 v1, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v0, vcc
; VI-NEXT:    v_add_u32_e32 v0, vcc, 4, v1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
;
; EG-LABEL: v_ashr_32_i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 2, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 3, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 4, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     LSHL * T0.W, T0.X, literal.x,
; EG-NEXT:    3(4.203895e-45), 0(0.000000e+00)
; EG-NEXT:     ADD_INT * T0.X, KC0[2].Z, PV.W,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, T0.W,
; EG-NEXT:     LSHR T1.X, PV.W, literal.x,
; EG-NEXT:     ASHR * T0.Y, T0.X, literal.y,
; EG-NEXT:    2(2.802597e-45), 31(4.344025e-44)
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #0
  %gep.in = getelementptr i64, i64 addrspace(1)* %in, i32 %tid
  %gep.out = getelementptr i64, i64 addrspace(1)* %out, i32 %tid
  %a = load i64, i64 addrspace(1)* %gep.in
  %result = ashr i64 %a, 32
  store i64 %result, i64 addrspace(1)* %gep.out
  ret void
}

define amdgpu_kernel void @s_ashr_63_i64(i64 addrspace(1)* %out, [8 x i32], i64 %a, [8 x i32], i64 %b) {
; SI-LABEL: s_ashr_63_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s6, s[0:1], 0x14
; SI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x1d
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_ashr_i32 s6, s6, 31
; SI-NEXT:    s_add_u32 s4, s6, s4
; SI-NEXT:    s_addc_u32 s5, s6, s5
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_ashr_63_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s6, s[0:1], 0x50
; VI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x74
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_ashr_i32 s6, s6, 31
; VI-NEXT:    s_add_u32 s4, s6, s4
; VI-NEXT:    s_addc_u32 s5, s6, s5
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
;
; EG-LABEL: s_ashr_63_i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 7, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     ASHR * T0.W, KC0[5].X, literal.x,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     ADD_INT T1.W, PV.W, KC0[7].Z,
; EG-NEXT:     ADDC_UINT * T2.W, PV.W, KC0[7].Y,
; EG-NEXT:     ADD_INT * T0.Y, PV.W, PS,
; EG-NEXT:     ADD_INT T0.X, T0.W, KC0[7].Y,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %result = ashr i64 %a, 63
  %add = add i64 %result, %b
  store i64 %add, i64 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_ashr_63_i64(i64 addrspace(1)* %out, i64 addrspace(1)* %in) {
; SI-LABEL: v_ashr_63_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    s_mov_b64 s[10:11], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 offset:4
; SI-NEXT:    s_mov_b64 s[4:5], s[0:1]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashrrev_i32_e32 v2, 31, v2
; SI-NEXT:    v_mov_b32_e32 v3, v2
; SI-NEXT:    buffer_store_dwordx2 v[2:3], v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_ashr_63_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 3, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s3
; VI-NEXT:    v_add_u32_e32 v1, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v0, vcc
; VI-NEXT:    v_add_u32_e32 v0, vcc, 4, v1
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_e32 v2, 31, v3
; VI-NEXT:    v_mov_b32_e32 v3, v2
; VI-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; VI-NEXT:    s_endpgm
;
; EG-LABEL: v_ashr_63_i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 2, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 5, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_32 T0.X, T0.X, 4, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     LSHL * T0.W, T0.X, literal.x,
; EG-NEXT:    3(4.203895e-45), 0(0.000000e+00)
; EG-NEXT:     ADD_INT * T0.X, KC0[2].Z, PV.W,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     ASHR T0.X, T0.X, literal.x,
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, T0.W,
; EG-NEXT:    31(4.344025e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR T1.X, PV.W, literal.x,
; EG-NEXT:     MOV * T0.Y, PV.X,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
  %tid = call i32 @llvm.amdgcn.workitem.id.x() #0
  %gep.in = getelementptr i64, i64 addrspace(1)* %in, i32 %tid
  %gep.out = getelementptr i64, i64 addrspace(1)* %out, i32 %tid
  %a = load i64, i64 addrspace(1)* %gep.in
  %result = ashr i64 %a, 63
  store i64 %result, i64 addrspace(1)* %gep.out
  ret void
}

attributes #0 = { nounwind readnone }
