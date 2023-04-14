; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=ipsccp < %s | FileCheck %s
;
;    void bar(int, float, double);
;
;    void foo(int N) {
;      float p = 3;
;      double q = 5;
;      N = 7;
;
;    #pragma omp parallel for firstprivate(q)
;      for (int i = 2; i < N; i++) {
;        bar(i, p, q);
;      }
;    }
;
; Verify the constant value of q is propagated into the outlined function.
;
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

%struct.ident_t = type { i32, i32, i32, i32, i8* }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr global %struct.ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr global %struct.ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8

define dso_local void @foo(i32 %N) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[N_ADDR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[P:%.*]] = alloca float, align 4
; CHECK-NEXT:    store i32 [[N:%.*]], i32* [[N_ADDR]], align 4
; CHECK-NEXT:    store float 3.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store i32 7, i32* [[N_ADDR]], align 4
; CHECK-NEXT:    call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* nonnull @1, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*, float*, i64)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* nonnull [[N_ADDR]], float* nonnull [[P]], i64 4617315517961601024)
; CHECK-NEXT:    ret void
;
entry:
  %N.addr = alloca i32, align 4
  %p = alloca float, align 4
  store i32 %N, i32* %N.addr, align 4
  store float 3.000000e+00, float* %p, align 4
  store i32 7, i32* %N.addr, align 4
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* nonnull @1, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*, float*, i64)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* nonnull %N.addr, float* nonnull %p, i64 4617315517961601024)
  ret void
}

define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32* dereferenceable(4) %N, float* dereferenceable(4) %p, i64 %q) {
; CHECK-LABEL: @.omp_outlined.(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[Q_ADDR:%.*]] = alloca i64, align 8
; CHECK-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i64 [[Q:%.*]], i64* [[Q_ADDR]], align 8
; CHECK-NEXT:    [[CONV:%.*]] = bitcast i64* [[Q_ADDR]] to double*
; CHECK-NEXT:    [[TMP:%.*]] = load i32, i32* [[N:%.*]], align 4
; CHECK-NEXT:    [[SUB3:%.*]] = add nsw i32 [[TMP]], -3
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP]], 2
; CHECK-NEXT:    br i1 [[CMP]], label [[OMP_PRECOND_THEN:%.*]], label [[OMP_PRECOND_END:%.*]]
; CHECK:       omp.precond.then:
; CHECK-NEXT:    store i32 0, i32* [[DOTOMP_LB]], align 4
; CHECK-NEXT:    store i32 [[SUB3]], i32* [[DOTOMP_UB]], align 4
; CHECK-NEXT:    store i32 1, i32* [[DOTOMP_STRIDE]], align 4
; CHECK-NEXT:    store i32 0, i32* [[DOTOMP_IS_LAST]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[DOTGLOBAL_TID_:%.*]], align 4
; CHECK-NEXT:    call void @__kmpc_for_static_init_4(%struct.ident_t* nonnull @0, i32 [[TMP5]], i32 34, i32* nonnull [[DOTOMP_IS_LAST]], i32* nonnull [[DOTOMP_LB]], i32* nonnull [[DOTOMP_UB]], i32* nonnull [[DOTOMP_STRIDE]], i32 1, i32 1)
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[DOTOMP_UB]], align 4
; CHECK-NEXT:    [[CMP6:%.*]] = icmp sgt i32 [[TMP6]], [[SUB3]]
; CHECK-NEXT:    br i1 [[CMP6]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    br label [[COND_END:%.*]]
; CHECK:       cond.false:
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* [[DOTOMP_UB]], align 4
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[SUB3]], [[COND_TRUE]] ], [ [[TMP7]], [[COND_FALSE]] ]
; CHECK-NEXT:    store i32 [[COND]], i32* [[DOTOMP_UB]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, i32* [[DOTOMP_LB]], align 4
; CHECK-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
; CHECK:       omp.inner.for.cond:
; CHECK-NEXT:    [[DOTOMP_IV_0:%.*]] = phi i32 [ [[TMP8]], [[COND_END]] ], [ [[ADD11:%.*]], [[OMP_INNER_FOR_INC:%.*]] ]
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, i32* [[DOTOMP_UB]], align 4
; CHECK-NEXT:    [[CMP8:%.*]] = icmp sgt i32 [[DOTOMP_IV_0]], [[TMP9]]
; CHECK-NEXT:    br i1 [[CMP8]], label [[OMP_INNER_FOR_COND_CLEANUP:%.*]], label [[OMP_INNER_FOR_BODY:%.*]]
; CHECK:       omp.inner.for.cond.cleanup:
; CHECK-NEXT:    br label [[OMP_INNER_FOR_END:%.*]]
; CHECK:       omp.inner.for.body:
; CHECK-NEXT:    [[ADD10:%.*]] = add nsw i32 [[DOTOMP_IV_0]], 2
; CHECK-NEXT:    [[TMP10:%.*]] = load float, float* [[P:%.*]], align 4
; CHECK-NEXT:    [[TMP11:%.*]] = load double, double* [[CONV]], align 8
; CHECK-NEXT:    call void @bar(i32 [[ADD10]], float [[TMP10]], double [[TMP11]])
; CHECK-NEXT:    br label [[OMP_BODY_CONTINUE:%.*]]
; CHECK:       omp.body.continue:
; CHECK-NEXT:    br label [[OMP_INNER_FOR_INC]]
; CHECK:       omp.inner.for.inc:
; CHECK-NEXT:    [[ADD11]] = add nsw i32 [[DOTOMP_IV_0]], 1
; CHECK-NEXT:    br label [[OMP_INNER_FOR_COND]]
; CHECK:       omp.inner.for.end:
; CHECK-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
; CHECK:       omp.loop.exit:
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* [[DOTGLOBAL_TID_]], align 4
; CHECK-NEXT:    call void @__kmpc_for_static_fini(%struct.ident_t* nonnull @0, i32 [[TMP12]])
; CHECK-NEXT:    br label [[OMP_PRECOND_END]]
; CHECK:       omp.precond.end:
; CHECK-NEXT:    ret void
;
entry:
  %q.addr = alloca i64, align 8
  %.omp.lb = alloca i32, align 4
  %.omp.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  store i64 %q, i64* %q.addr, align 8
  %conv = bitcast i64* %q.addr to double*
  %tmp = load i32, i32* %N, align 4
  %sub3 = add nsw i32 %tmp, -3
  %cmp = icmp sgt i32 %tmp, 2
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  store i32 0, i32* %.omp.lb, align 4
  store i32 %sub3, i32* %.omp.ub, align 4
  store i32 1, i32* %.omp.stride, align 4
  store i32 0, i32* %.omp.is_last, align 4
  %tmp5 = load i32, i32* %.global_tid., align 4
  call void @__kmpc_for_static_init_4(%struct.ident_t* nonnull @0, i32 %tmp5, i32 34, i32* nonnull %.omp.is_last, i32* nonnull %.omp.lb, i32* nonnull %.omp.ub, i32* nonnull %.omp.stride, i32 1, i32 1)
  %tmp6 = load i32, i32* %.omp.ub, align 4
  %cmp6 = icmp sgt i32 %tmp6, %sub3
  br i1 %cmp6, label %cond.true, label %cond.false

cond.true:                                        ; preds = %omp.precond.then
  br label %cond.end

cond.false:                                       ; preds = %omp.precond.then
  %tmp7 = load i32, i32* %.omp.ub, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %sub3, %cond.true ], [ %tmp7, %cond.false ]
  store i32 %cond, i32* %.omp.ub, align 4
  %tmp8 = load i32, i32* %.omp.lb, align 4
  br label %omp.inner.for.cond

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %.omp.iv.0 = phi i32 [ %tmp8, %cond.end ], [ %add11, %omp.inner.for.inc ]
  %tmp9 = load i32, i32* %.omp.ub, align 4
  %cmp8 = icmp sgt i32 %.omp.iv.0, %tmp9
  br i1 %cmp8, label %omp.inner.for.cond.cleanup, label %omp.inner.for.body

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %add10 = add nsw i32 %.omp.iv.0, 2
  %tmp10 = load float, float* %p, align 4
  %tmp11 = load double, double* %conv, align 8
  call void @bar(i32 %add10, float %tmp10, double %tmp11)
  br label %omp.body.continue

omp.body.continue:                                ; preds = %omp.inner.for.body
  br label %omp.inner.for.inc

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %add11 = add nsw i32 %.omp.iv.0, 1
  br label %omp.inner.for.cond

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %tmp12 = load i32, i32* %.global_tid., align 4
  call void @__kmpc_for_static_fini(%struct.ident_t* nonnull @0, i32 %tmp12)
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %omp.loop.exit, %entry
  ret void
}

declare dso_local void @__kmpc_for_static_init_4(%struct.ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

declare dso_local void @bar(i32, float, double)

declare dso_local void @__kmpc_for_static_fini(%struct.ident_t*, i32)

declare !callback !0 dso_local void @__kmpc_fork_call(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

!1 = !{i64 2, i64 -1, i64 -1, i1 true}
!0 = !{!1}
