; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -early-cse -earlycse-debug-hash < %s | FileCheck %s

@var = global i32 undef
declare void @foo() nounwind

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:    call void @foo() #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    store i32 2, i32* @var, align 4
; CHECK-NEXT:    ret void
;
  store i32 1, i32* @var
  call void @foo() writeonly
  store i32 2, i32* @var
  ret void
}
