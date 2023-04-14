; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; ANDV

define i8 @andv_nxv8i8(<vscale x 8 x i8> %a) {
; CHECK-LABEL: andv_nxv8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    andv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.and.nxv8i8(<vscale x 8 x i8> %a)
  ret i8 %res
}

define i32 @andv_nxv8i32(<vscale x 8 x i32> %a) {
; CHECK-LABEL: andv_nxv8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    andv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.and.nxv8i32(<vscale x 8 x i32> %a)
  ret i32 %res
}

; ORV

define i32 @orv_nxv2i32(<vscale x 2 x i32> %a) {
; CHECK-LABEL: orv_nxv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    orv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.or.nxv2i32(<vscale x 2 x i32> %a)
  ret i32 %res
}

define i64 @orv_nxv8i64(<vscale x 8 x i64> %a) {
; CHECK-LABEL: orv_nxv8i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    orr z1.d, z1.d, z3.d
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    orv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.or.nxv8i64(<vscale x 8 x i64> %a)
  ret i64 %res
}

; XORV

define i16 @xorv_nxv2i16(<vscale x 2 x i16> %a) {
; CHECK-LABEL: xorv_nxv2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    eorv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.xor.nxv2i16(<vscale x 2 x i16> %a)
  ret i16 %res
}

define i32 @xorv_nxv8i32(<vscale x 8 x i32> %a) {
; CHECK-LABEL: xorv_nxv8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    eor z0.d, z0.d, z1.d
; CHECK-NEXT:    eorv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.xor.nxv8i32(<vscale x 8 x i32> %a)
  ret i32 %res
}

; UADDV

define i16 @uaddv_nxv4i16(<vscale x 4 x i16> %a) {
; CHECK-LABEL: uaddv_nxv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    uaddv d0, p0, z0.s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.add.nxv4i16(<vscale x 4 x i16> %a)
  ret i16 %res
}

define i16 @uaddv_nxv16i16(<vscale x 16 x i16> %a) {
; CHECK-LABEL: uaddv_nxv16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    add z0.h, z0.h, z1.h
; CHECK-NEXT:    uaddv d0, p0, z0.h
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.add.nxv16i16(<vscale x 16 x i16> %a)
  ret i16 %res
}

define i32 @uaddv_nxv16i32(<vscale x 16 x i32> %a) {
; CHECK-LABEL: uaddv_nxv16i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add z1.s, z1.s, z3.s
; CHECK-NEXT:    add z0.s, z0.s, z2.s
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    add z0.s, z0.s, z1.s
; CHECK-NEXT:    uaddv d0, p0, z0.s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.add.nxv16i32(<vscale x 16 x i32> %a)
  ret i32 %res
}

; UMINV

define i32 @umin_nxv2i32(<vscale x 2 x i32> %a) {
; CHECK-LABEL: umin_nxv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    and z0.d, z0.d, #0xffffffff
; CHECK-NEXT:    uminv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.umin.nxv2i32(<vscale x 2 x i32> %a)
  ret i32 %res
}

define i64 @umin_nxv4i64(<vscale x 4 x i64> %a) {
; CHECK-LABEL: umin_nxv4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    umin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    uminv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.umin.nxv4i64(<vscale x 4 x i64> %a)
  ret i64 %res
}

; SMINV

define i8 @smin_nxv4i8(<vscale x 4 x i8> %a) {
; CHECK-LABEL: smin_nxv4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    sxtb z0.s, p0/m, z0.s
; CHECK-NEXT:    sminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.smin.nxv4i8(<vscale x 4 x i8> %a)
  ret i8 %res
}

define i32 @smin_nxv8i32(<vscale x 8 x i32> %a) {
; CHECK-LABEL: smin_nxv8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    smin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    sminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.smin.nxv8i32(<vscale x 8 x i32> %a)
  ret i32 %res
}

; UMAXV

define i16 @smin_nxv16i16(<vscale x 16 x i16> %a) {
; CHECK-LABEL: smin_nxv16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    umax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    umaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.umax.nxv16i16(<vscale x 16 x i16> %a)
  ret i16 %res
}

; SMAXV

define i64 @smin_nxv8i64(<vscale x 8 x i64> %a) {
; CHECK-LABEL: smin_nxv8i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    smax z1.d, p0/m, z1.d, z3.d
; CHECK-NEXT:    smax z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    smax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    smaxv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.smax.nxv8i64(<vscale x 8 x i64> %a)
  ret i64 %res
}

declare i8 @llvm.vector.reduce.and.nxv8i8(<vscale x 8 x i8>)
declare i32 @llvm.vector.reduce.and.nxv8i32(<vscale x 8 x i32>)

declare i32 @llvm.vector.reduce.or.nxv2i32(<vscale x 2 x i32>)
declare i64 @llvm.vector.reduce.or.nxv8i64(<vscale x 8 x i64>)

declare i16 @llvm.vector.reduce.xor.nxv2i16(<vscale x 2 x i16>)
declare i32 @llvm.vector.reduce.xor.nxv8i32(<vscale x 8 x i32>)

declare i16 @llvm.vector.reduce.add.nxv4i16(<vscale x 4 x i16>)
declare i16 @llvm.vector.reduce.add.nxv16i16(<vscale x 16 x i16>)
declare i32 @llvm.vector.reduce.add.nxv16i32(<vscale x 16 x i32>)

declare i32 @llvm.vector.reduce.umin.nxv2i32(<vscale x 2 x i32>)
declare i64 @llvm.vector.reduce.umin.nxv4i64(<vscale x 4 x i64>)

declare i8 @llvm.vector.reduce.smin.nxv4i8(<vscale x 4 x i8>)
declare i32 @llvm.vector.reduce.smin.nxv8i32(<vscale x 8 x i32>)

declare i16 @llvm.vector.reduce.umax.nxv16i16(<vscale x 16 x i16>)

declare i64 @llvm.vector.reduce.smax.nxv8i64(<vscale x 8 x i64>)
