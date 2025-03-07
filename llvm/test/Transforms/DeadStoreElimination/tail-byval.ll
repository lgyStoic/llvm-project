; RUN: opt -dse -S < %s | FileCheck %s

; Don't eliminate stores to allocas before tail calls to functions that use
; byval. It's correct to mark calls like these as 'tail'. To implement this tail
; call, the backend should copy the bytes from the alloca into the argument area
; before clearing the stack.

target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

declare void @g(ptr byval(i32) %p)

define void @f(ptr byval(i32) %x) {
entry:
  %p = alloca i32
  %v = load i32, ptr %x
  store i32 %v, ptr %p
  tail call void @g(ptr byval(i32) %p)
  ret void
}
; CHECK-LABEL: define void @f(ptr byval(i32) %x)
; CHECK:   store i32 %v, ptr %p
; CHECK:   tail call void @g(ptr byval(i32) %p)
