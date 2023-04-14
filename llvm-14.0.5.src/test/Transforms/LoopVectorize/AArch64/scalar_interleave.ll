; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-vectorize -S -o - < %s | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-arm-none-eabi"

; This test is not vectorized on AArch64 due to requiring predicated loads.
; It should also not be interleaved as the predicated interleaving will just
; create less efficient code.

define void @arm_correlate_f16(half* nocapture noundef readonly %pSrcA, i32 noundef %srcALen, half* nocapture noundef readonly %pSrcB, i32 noundef %srcBLen, half* nocapture noundef writeonly %pDst) {
; CHECK-LABEL: @arm_correlate_f16(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[SRCBLEN:%.*]], -1
; CHECK-NEXT:    [[IDX_EXT:%.*]] = zext i32 [[SUB]] to i64
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds half, half* [[PSRCB:%.*]], i64 [[IDX_EXT]]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[SRCALEN:%.*]], -2
; CHECK-NEXT:    [[SUB1:%.*]] = add i32 [[ADD]], [[SRCBLEN]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[SRCALEN]], [[SRCBLEN]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[SUB2:%.*]] = sub i32 [[SRCALEN]], [[SRCBLEN]]
; CHECK-NEXT:    [[IDX_EXT3:%.*]] = zext i32 [[SUB2]] to i64
; CHECK-NEXT:    [[ADD_PTR4:%.*]] = getelementptr inbounds half, half* [[PDST:%.*]], i64 [[IDX_EXT3]]
; CHECK-NEXT:    br label [[IF_END12:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[CMP5:%.*]] = icmp ult i32 [[SRCALEN]], [[SRCBLEN]]
; CHECK-NEXT:    br i1 [[CMP5]], label [[IF_THEN6:%.*]], label [[IF_END12]]
; CHECK:       if.then6:
; CHECK-NEXT:    [[SUB7:%.*]] = add i32 [[SRCALEN]], -1
; CHECK-NEXT:    [[IDX_EXT8:%.*]] = zext i32 [[SUB7]] to i64
; CHECK-NEXT:    [[ADD_PTR9:%.*]] = getelementptr inbounds half, half* [[PSRCA:%.*]], i64 [[IDX_EXT8]]
; CHECK-NEXT:    [[IDX_EXT10:%.*]] = zext i32 [[SUB1]] to i64
; CHECK-NEXT:    [[ADD_PTR11:%.*]] = getelementptr inbounds half, half* [[PDST]], i64 [[IDX_EXT10]]
; CHECK-NEXT:    br label [[IF_END12]]
; CHECK:       if.end12:
; CHECK-NEXT:    [[SRCALEN_ADDR_0:%.*]] = phi i32 [ [[SRCALEN]], [[IF_THEN]] ], [ [[SRCBLEN]], [[IF_THEN6]] ], [ [[SRCALEN]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[SRCBLEN_ADDR_0:%.*]] = phi i32 [ [[SRCBLEN]], [[IF_THEN]] ], [ [[SRCALEN]], [[IF_THEN6]] ], [ [[SRCBLEN]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[PDST_ADDR_0:%.*]] = phi half* [ [[ADD_PTR4]], [[IF_THEN]] ], [ [[ADD_PTR11]], [[IF_THEN6]] ], [ [[PDST]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[PIN1_0:%.*]] = phi half* [ [[PSRCA]], [[IF_THEN]] ], [ [[PSRCB]], [[IF_THEN6]] ], [ [[PSRCA]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[PIN2_0:%.*]] = phi half* [ [[ADD_PTR]], [[IF_THEN]] ], [ [[ADD_PTR9]], [[IF_THEN6]] ], [ [[ADD_PTR]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[CMP27:%.*]] = phi i64 [ 1, [[IF_THEN]] ], [ -1, [[IF_THEN6]] ], [ 1, [[IF_ELSE]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[SRCBLEN]], [[SRCALEN]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[TMP0]], -1
; CHECK-NEXT:    br label [[FOR_COND14_PREHEADER:%.*]]
; CHECK:       for.cond14.preheader:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i32 [ 1, [[IF_END12]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_END:%.*]] ]
; CHECK-NEXT:    [[I_077:%.*]] = phi i32 [ 0, [[IF_END12]] ], [ [[INC33:%.*]], [[FOR_END]] ]
; CHECK-NEXT:    [[PDST_ADDR_176:%.*]] = phi half* [ [[PDST_ADDR_0]], [[IF_END12]] ], [ [[PDST_ADDR_2:%.*]], [[FOR_END]] ]
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[INDVARS_IV]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[MUL1:%.*]] = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 1, i32 [[I_077]])
; CHECK-NEXT:    [[MUL_RESULT:%.*]] = extractvalue { i32, i1 } [[MUL1]], 0
; CHECK-NEXT:    [[MUL_OVERFLOW:%.*]] = extractvalue { i32, i1 } [[MUL1]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 [[I_077]], [[MUL_RESULT]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[TMP2]], [[I_077]]
; CHECK-NEXT:    [[TMP4:%.*]] = or i1 [[TMP3]], [[MUL_OVERFLOW]]
; CHECK-NEXT:    br i1 [[TMP4]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[INDVARS_IV]], 2
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[INDVARS_IV]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_LOAD_CONTINUE9:%.*]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi half [ 0xH0000, [[VECTOR_PH]] ], [ [[PREDPHI:%.*]], [[PRED_LOAD_CONTINUE9]] ]
; CHECK-NEXT:    [[VEC_PHI3:%.*]] = phi half [ 0xH0000, [[VECTOR_PH]] ], [ [[PREDPHI10:%.*]], [[PRED_LOAD_CONTINUE9]] ]
; CHECK-NEXT:    [[INDUCTION:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[INDUCTION2:%.*]] = add i32 [[INDEX]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = sub i32 [[I_077]], [[INDUCTION]]
; CHECK-NEXT:    [[TMP6:%.*]] = sub i32 [[I_077]], [[INDUCTION2]]
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ult i32 [[TMP5]], [[SRCBLEN_ADDR_0]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ult i32 [[TMP6]], [[SRCBLEN_ADDR_0]]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ult i32 [[INDUCTION]], [[SRCALEN_ADDR_0]]
; CHECK-NEXT:    [[TMP10:%.*]] = icmp ult i32 [[INDUCTION2]], [[SRCALEN_ADDR_0]]
; CHECK-NEXT:    [[TMP11:%.*]] = and i1 [[TMP9]], [[TMP7]]
; CHECK-NEXT:    [[TMP12:%.*]] = and i1 [[TMP10]], [[TMP8]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[PRED_LOAD_IF:%.*]], label [[PRED_LOAD_CONTINUE:%.*]]
; CHECK:       pred.load.if:
; CHECK-NEXT:    [[TMP13:%.*]] = zext i32 [[INDUCTION]] to i64
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds half, half* [[PIN1_0]], i64 [[TMP13]]
; CHECK-NEXT:    [[TMP15:%.*]] = load half, half* [[TMP14]], align 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE]]
; CHECK:       pred.load.continue:
; CHECK-NEXT:    [[TMP16:%.*]] = phi half [ poison, [[VECTOR_BODY]] ], [ [[TMP15]], [[PRED_LOAD_IF]] ]
; CHECK-NEXT:    br i1 [[TMP12]], label [[PRED_LOAD_IF4:%.*]], label [[PRED_LOAD_CONTINUE5:%.*]]
; CHECK:       pred.load.if4:
; CHECK-NEXT:    [[TMP17:%.*]] = zext i32 [[INDUCTION2]] to i64
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds half, half* [[PIN1_0]], i64 [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = load half, half* [[TMP18]], align 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE5]]
; CHECK:       pred.load.continue5:
; CHECK-NEXT:    [[TMP20:%.*]] = phi half [ poison, [[PRED_LOAD_CONTINUE]] ], [ [[TMP19]], [[PRED_LOAD_IF4]] ]
; CHECK-NEXT:    br i1 [[TMP11]], label [[PRED_LOAD_IF6:%.*]], label [[PRED_LOAD_CONTINUE7:%.*]]
; CHECK:       pred.load.if6:
; CHECK-NEXT:    [[TMP21:%.*]] = sub nsw i32 0, [[TMP5]]
; CHECK-NEXT:    [[TMP22:%.*]] = sext i32 [[TMP21]] to i64
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds half, half* [[PIN2_0]], i64 [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = load half, half* [[TMP23]], align 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE7]]
; CHECK:       pred.load.continue7:
; CHECK-NEXT:    [[TMP25:%.*]] = phi half [ poison, [[PRED_LOAD_CONTINUE5]] ], [ [[TMP24]], [[PRED_LOAD_IF6]] ]
; CHECK-NEXT:    br i1 [[TMP12]], label [[PRED_LOAD_IF8:%.*]], label [[PRED_LOAD_CONTINUE9]]
; CHECK:       pred.load.if8:
; CHECK-NEXT:    [[TMP26:%.*]] = sub nsw i32 0, [[TMP6]]
; CHECK-NEXT:    [[TMP27:%.*]] = sext i32 [[TMP26]] to i64
; CHECK-NEXT:    [[TMP28:%.*]] = getelementptr inbounds half, half* [[PIN2_0]], i64 [[TMP27]]
; CHECK-NEXT:    [[TMP29:%.*]] = load half, half* [[TMP28]], align 2
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE9]]
; CHECK:       pred.load.continue9:
; CHECK-NEXT:    [[TMP30:%.*]] = phi half [ poison, [[PRED_LOAD_CONTINUE7]] ], [ [[TMP29]], [[PRED_LOAD_IF8]] ]
; CHECK-NEXT:    [[TMP31:%.*]] = fmul fast half [[TMP25]], [[TMP16]]
; CHECK-NEXT:    [[TMP32:%.*]] = fmul fast half [[TMP30]], [[TMP20]]
; CHECK-NEXT:    [[TMP33:%.*]] = fadd fast half [[TMP31]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP34:%.*]] = fadd fast half [[TMP32]], [[VEC_PHI3]]
; CHECK-NEXT:    [[TMP35:%.*]] = xor i1 [[TMP11]], true
; CHECK-NEXT:    [[TMP36:%.*]] = xor i1 [[TMP12]], true
; CHECK-NEXT:    [[PREDPHI]] = select i1 [[TMP35]], half [[VEC_PHI]], half [[TMP33]]
; CHECK-NEXT:    [[PREDPHI10]] = select i1 [[TMP36]], half [[VEC_PHI3]], half [[TMP34]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP37:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP37]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = fadd fast half [[PREDPHI10]], [[PREDPHI]]
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[INDVARS_IV]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_COND14_PREHEADER]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi half [ 0xH0000, [[VECTOR_SCEVCHECK]] ], [ 0xH0000, [[FOR_COND14_PREHEADER]] ], [ [[BIN_RDX]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY16:%.*]]
; CHECK:       for.body16:
; CHECK-NEXT:    [[J_074:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_INC:%.*]] ]
; CHECK-NEXT:    [[SUM_073:%.*]] = phi half [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[SUM_1:%.*]], [[FOR_INC]] ]
; CHECK-NEXT:    [[SUB17:%.*]] = sub i32 [[I_077]], [[J_074]]
; CHECK-NEXT:    [[CMP18:%.*]] = icmp ult i32 [[SUB17]], [[SRCBLEN_ADDR_0]]
; CHECK-NEXT:    [[CMP19:%.*]] = icmp ult i32 [[J_074]], [[SRCALEN_ADDR_0]]
; CHECK-NEXT:    [[OR_COND:%.*]] = and i1 [[CMP19]], [[CMP18]]
; CHECK-NEXT:    br i1 [[OR_COND]], label [[IF_THEN20:%.*]], label [[FOR_INC]]
; CHECK:       if.then20:
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[J_074]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds half, half* [[PIN1_0]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[TMP38:%.*]] = load half, half* [[ARRAYIDX]], align 2
; CHECK-NEXT:    [[SUB22:%.*]] = sub nsw i32 0, [[SUB17]]
; CHECK-NEXT:    [[IDXPROM23:%.*]] = sext i32 [[SUB22]] to i64
; CHECK-NEXT:    [[ARRAYIDX24:%.*]] = getelementptr inbounds half, half* [[PIN2_0]], i64 [[IDXPROM23]]
; CHECK-NEXT:    [[TMP39:%.*]] = load half, half* [[ARRAYIDX24]], align 2
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast half [[TMP39]], [[TMP38]]
; CHECK-NEXT:    [[ADD25:%.*]] = fadd fast half [[MUL]], [[SUM_073]]
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[SUM_1]] = phi half [ [[ADD25]], [[IF_THEN20]] ], [ [[SUM_073]], [[FOR_BODY16]] ]
; CHECK-NEXT:    [[INC]] = add nuw i32 [[J_074]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], [[INDVARS_IV]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY16]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[SUM_1_LCSSA:%.*]] = phi half [ [[SUM_1]], [[FOR_INC]] ], [ [[BIN_RDX]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    [[PDST_ADDR_2]] = getelementptr inbounds half, half* [[PDST_ADDR_176]], i64 [[CMP27]]
; CHECK-NEXT:    store half [[SUM_1_LCSSA]], half* [[PDST_ADDR_176]], align 2
; CHECK-NEXT:    [[INC33]] = add nuw i32 [[I_077]], 1
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i32 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND78_NOT:%.*]] = icmp eq i32 [[INC33]], [[TMP1]]
; CHECK-NEXT:    br i1 [[EXITCOND78_NOT]], label [[FOR_END34:%.*]], label [[FOR_COND14_PREHEADER]]
; CHECK:       for.end34:
; CHECK-NEXT:    ret void
;
entry:
  %sub = add i32 %srcBLen, -1
  %idx.ext = zext i32 %sub to i64
  %add.ptr = getelementptr inbounds half, half* %pSrcB, i64 %idx.ext
  %add = add i32 %srcALen, -2
  %sub1 = add i32 %add, %srcBLen
  %cmp = icmp ugt i32 %srcALen, %srcBLen
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %sub2 = sub i32 %srcALen, %srcBLen
  %idx.ext3 = zext i32 %sub2 to i64
  %add.ptr4 = getelementptr inbounds half, half* %pDst, i64 %idx.ext3
  br label %if.end12

if.else:                                          ; preds = %entry
  %cmp5 = icmp ult i32 %srcALen, %srcBLen
  br i1 %cmp5, label %if.then6, label %if.end12

if.then6:                                         ; preds = %if.else
  %sub7 = add i32 %srcALen, -1
  %idx.ext8 = zext i32 %sub7 to i64
  %add.ptr9 = getelementptr inbounds half, half* %pSrcA, i64 %idx.ext8
  %idx.ext10 = zext i32 %sub1 to i64
  %add.ptr11 = getelementptr inbounds half, half* %pDst, i64 %idx.ext10
  br label %if.end12

if.end12:                                         ; preds = %if.else, %if.then6, %if.then
  %srcALen.addr.0 = phi i32 [ %srcALen, %if.then ], [ %srcBLen, %if.then6 ], [ %srcALen, %if.else ]
  %srcBLen.addr.0 = phi i32 [ %srcBLen, %if.then ], [ %srcALen, %if.then6 ], [ %srcBLen, %if.else ]
  %pDst.addr.0 = phi half* [ %add.ptr4, %if.then ], [ %add.ptr11, %if.then6 ], [ %pDst, %if.else ]
  %pIn1.0 = phi half* [ %pSrcA, %if.then ], [ %pSrcB, %if.then6 ], [ %pSrcA, %if.else ]
  %pIn2.0 = phi half* [ %add.ptr, %if.then ], [ %add.ptr9, %if.then6 ], [ %add.ptr, %if.else ]
  %cmp27 = phi i64 [ 1, %if.then ], [ -1, %if.then6 ], [ 1, %if.else ]
  %0 = add i32 %srcBLen, %srcALen
  %1 = add i32 %0, -1
  br label %for.cond14.preheader

for.cond14.preheader:                             ; preds = %if.end12, %for.end
  %indvars.iv = phi i32 [ 1, %if.end12 ], [ %indvars.iv.next, %for.end ]
  %i.077 = phi i32 [ 0, %if.end12 ], [ %inc33, %for.end ]
  %pDst.addr.176 = phi half* [ %pDst.addr.0, %if.end12 ], [ %pDst.addr.2, %for.end ]
  br label %for.body16

for.body16:                                       ; preds = %for.cond14.preheader, %for.inc
  %j.074 = phi i32 [ 0, %for.cond14.preheader ], [ %inc, %for.inc ]
  %sum.073 = phi half [ 0xH0000, %for.cond14.preheader ], [ %sum.1, %for.inc ]
  %sub17 = sub i32 %i.077, %j.074
  %cmp18 = icmp ult i32 %sub17, %srcBLen.addr.0
  %cmp19 = icmp ult i32 %j.074, %srcALen.addr.0
  %or.cond = and i1 %cmp19, %cmp18
  br i1 %or.cond, label %if.then20, label %for.inc

if.then20:                                        ; preds = %for.body16
  %idxprom = zext i32 %j.074 to i64
  %arrayidx = getelementptr inbounds half, half* %pIn1.0, i64 %idxprom
  %2 = load half, half* %arrayidx, align 2
  %sub22 = sub nsw i32 0, %sub17
  %idxprom23 = sext i32 %sub22 to i64
  %arrayidx24 = getelementptr inbounds half, half* %pIn2.0, i64 %idxprom23
  %3 = load half, half* %arrayidx24, align 2
  %mul = fmul fast half %3, %2
  %add25 = fadd fast half %mul, %sum.073
  br label %for.inc

for.inc:                                          ; preds = %for.body16, %if.then20
  %sum.1 = phi half [ %add25, %if.then20 ], [ %sum.073, %for.body16 ]
  %inc = add nuw i32 %j.074, 1
  %exitcond = icmp eq i32 %inc, %indvars.iv
  br i1 %exitcond, label %for.end, label %for.body16

for.end:                                          ; preds = %for.inc
  %sum.1.lcssa = phi half [ %sum.1, %for.inc ]
  %pDst.addr.2 = getelementptr inbounds half, half* %pDst.addr.176, i64 %cmp27
  store half %sum.1.lcssa, half* %pDst.addr.176, align 2
  %inc33 = add nuw i32 %i.077, 1
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond78.not = icmp eq i32 %inc33, %1
  br i1 %exitcond78.not, label %for.end34, label %for.cond14.preheader

for.end34:                                        ; preds = %for.end
  ret void
}
