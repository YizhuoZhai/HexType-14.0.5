; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; REQUIRES: asserts

; RUN: opt -passes='assume-builder,verify' --enable-knowledge-retention --debug-counter=assume-builder-counter-skip=5,assume-builder-counter-count=1 -S %s | FileCheck %s --check-prefixes=COUNTER1
; RUN: opt -passes='assume-builder,verify' --enable-knowledge-retention --debug-counter=assume-builder-counter-skip=1,assume-builder-counter-count=3 -S %s | FileCheck %s --check-prefixes=COUNTER2
; RUN: opt -passes='assume-builder,verify' --enable-knowledge-retention --debug-counter=assume-builder-counter-skip=2,assume-builder-counter-count=200 -S %s | FileCheck %s --check-prefixes=COUNTER3

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

declare void @func(i32*, i32*)
declare void @func_cold(i32*) cold willreturn nounwind
declare void @func_strbool(i32*) "no-jump-tables"
declare void @func_many(i32*) "no-jump-tables" nounwind "less-precise-fpmad" willreturn norecurse
declare void @func_argattr(i32* align 8, i32* nonnull) nounwind
declare void @func_argattr2(i32* noundef align 8, i32* noundef nonnull) nounwind
declare void @may_throw()

define void @test(i32* %P, i32* %P1, i32* %P2, i32* %P3) {
; COUNTER1-LABEL: define {{[^@]+}}@test
; COUNTER1-SAME: (i32* [[P:%.*]], i32* [[P1:%.*]], i32* [[P2:%.*]], i32* [[P3:%.*]]) {
; COUNTER1-NEXT:    call void @func(i32* nonnull dereferenceable(16) [[P]], i32* null)
; COUNTER1-NEXT:    call void @func(i32* dereferenceable(12) [[P1]], i32* nonnull [[P]])
; COUNTER1-NEXT:    call void @func_cold(i32* dereferenceable(12) [[P1]]) [[ATTR5:#.*]]
; COUNTER1-NEXT:    call void @func_cold(i32* dereferenceable(12) [[P1]])
; COUNTER1-NEXT:    call void @func(i32* [[P1]], i32* [[P]])
; COUNTER1-NEXT:    call void @func_strbool(i32* [[P1]])
; COUNTER1-NEXT:    call void @func(i32* dereferenceable(32) [[P]], i32* dereferenceable(8) [[P]])
; COUNTER1-NEXT:    call void @func_many(i32* align 8 [[P1]])
; COUNTER1-NEXT:    call void @llvm.assume(i1 true) [ "noundef"(i32* [[P1]]), "align"(i32* [[P1]], i64 8) ]
; COUNTER1-NEXT:    call void @func_many(i32* noundef align 8 [[P1]])
; COUNTER1-NEXT:    call void @func_argattr(i32* [[P2]], i32* [[P3]])
; COUNTER1-NEXT:    call void @func_argattr2(i32* [[P2]], i32* [[P3]])
; COUNTER1-NEXT:    call void @func(i32* nonnull [[P1]], i32* nonnull [[P]])
; COUNTER1-NEXT:    call void @func(i32* noundef nonnull [[P1]], i32* noundef nonnull [[P]])
; COUNTER1-NEXT:    ret void
;
; COUNTER2-LABEL: define {{[^@]+}}@test
; COUNTER2-SAME: (i32* [[P:%.*]], i32* [[P1:%.*]], i32* [[P2:%.*]], i32* [[P3:%.*]]) {
; COUNTER2-NEXT:    call void @func(i32* nonnull dereferenceable(16) [[P]], i32* null)
; COUNTER2-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(i32* [[P1]], i64 12) ]
; COUNTER2-NEXT:    call void @func(i32* dereferenceable(12) [[P1]], i32* nonnull [[P]])
; COUNTER2-NEXT:    call void @llvm.assume(i1 true) [ "cold"() ]
; COUNTER2-NEXT:    call void @func_cold(i32* dereferenceable(12) [[P1]]) [[ATTR5:#.*]]
; COUNTER2-NEXT:    call void @llvm.assume(i1 true) [ "cold"() ]
; COUNTER2-NEXT:    call void @func_cold(i32* dereferenceable(12) [[P1]])
; COUNTER2-NEXT:    call void @func(i32* [[P1]], i32* [[P]])
; COUNTER2-NEXT:    call void @func_strbool(i32* [[P1]])
; COUNTER2-NEXT:    call void @func(i32* dereferenceable(32) [[P]], i32* dereferenceable(8) [[P]])
; COUNTER2-NEXT:    call void @func_many(i32* align 8 [[P1]])
; COUNTER2-NEXT:    call void @func_many(i32* noundef align 8 [[P1]])
; COUNTER2-NEXT:    call void @func_argattr(i32* [[P2]], i32* [[P3]])
; COUNTER2-NEXT:    call void @func_argattr2(i32* [[P2]], i32* [[P3]])
; COUNTER2-NEXT:    call void @func(i32* nonnull [[P1]], i32* nonnull [[P]])
; COUNTER2-NEXT:    call void @func(i32* noundef nonnull [[P1]], i32* noundef nonnull [[P]])
; COUNTER2-NEXT:    ret void
;
; COUNTER3-LABEL: define {{[^@]+}}@test
; COUNTER3-SAME: (i32* [[P:%.*]], i32* [[P1:%.*]], i32* [[P2:%.*]], i32* [[P3:%.*]]) {
; COUNTER3-NEXT:    call void @func(i32* nonnull dereferenceable(16) [[P]], i32* null)
; COUNTER3-NEXT:    call void @func(i32* dereferenceable(12) [[P1]], i32* nonnull [[P]])
; COUNTER3-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(i32* [[P1]], i64 12), "cold"() ]
; COUNTER3-NEXT:    call void @func_cold(i32* dereferenceable(12) [[P1]]) [[ATTR5:#.*]]
; COUNTER3-NEXT:    call void @llvm.assume(i1 true) [ "cold"() ]
; COUNTER3-NEXT:    call void @func_cold(i32* dereferenceable(12) [[P1]])
; COUNTER3-NEXT:    call void @func(i32* [[P1]], i32* [[P]])
; COUNTER3-NEXT:    call void @func_strbool(i32* [[P1]])
; COUNTER3-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(i32* [[P]], i64 32) ]
; COUNTER3-NEXT:    call void @func(i32* dereferenceable(32) [[P]], i32* dereferenceable(8) [[P]])
; COUNTER3-NEXT:    call void @func_many(i32* align 8 [[P1]])
; COUNTER3-NEXT:    call void @llvm.assume(i1 true) [ "noundef"(i32* [[P1]]), "align"(i32* [[P1]], i64 8) ]
; COUNTER3-NEXT:    call void @func_many(i32* noundef align 8 [[P1]])
; COUNTER3-NEXT:    call void @func_argattr(i32* [[P2]], i32* [[P3]])
; COUNTER3-NEXT:    call void @llvm.assume(i1 true) [ "noundef"(i32* [[P2]]), "align"(i32* [[P2]], i64 8), "noundef"(i32* [[P3]]), "nonnull"(i32* [[P3]]) ]
; COUNTER3-NEXT:    call void @func_argattr2(i32* [[P2]], i32* [[P3]])
; COUNTER3-NEXT:    call void @func(i32* nonnull [[P1]], i32* nonnull [[P]])
; COUNTER3-NEXT:    call void @llvm.assume(i1 true) [ "nonnull"(i32* [[P1]]), "noundef"(i32* [[P]]), "nonnull"(i32* [[P]]) ]
; COUNTER3-NEXT:    call void @func(i32* noundef nonnull [[P1]], i32* noundef nonnull [[P]])
; COUNTER3-NEXT:    ret void
;
  call void @func(i32* nonnull dereferenceable(16) %P, i32* null)
  call void @func(i32* dereferenceable(12) %P1, i32* nonnull %P)
  call void @func_cold(i32* dereferenceable(12) %P1) cold
  call void @func_cold(i32* dereferenceable(12) %P1)
  call void @func(i32* %P1, i32* %P)
  call void @func_strbool(i32* %P1)
  call void @func(i32* dereferenceable(32) %P, i32* dereferenceable(8) %P)
  call void @func_many(i32* align 8 %P1)
  call void @func_many(i32* align 8 noundef %P1)
  call void @func_argattr(i32* %P2, i32* %P3)
  call void @func_argattr2(i32* %P2, i32* %P3)
  call void @func(i32* nonnull %P1, i32* nonnull %P)
  call void @func(i32* nonnull noundef %P1, i32* nonnull noundef %P)
  ret void
}
