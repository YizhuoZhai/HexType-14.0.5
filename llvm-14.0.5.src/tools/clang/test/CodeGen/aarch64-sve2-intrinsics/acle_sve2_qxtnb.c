// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -fsyntax-only -verify -verify-ignore-unexpected=error %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -fsyntax-only -verify=overload -verify-ignore-unexpected=error %s

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svqxtnb_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sqxtnb.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svqxtnb_s16u11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sqxtnb.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svqxtnb_s16(svint16_t op1)
{
  // overload-warning@+2 {{implicit declaration of function 'svqxtnb'}}
  // expected-warning@+1 {{implicit declaration of function 'svqxtnb_s16'}}
  return SVE_ACLE_FUNC(svqxtnb,_s16,,)(op1);
}

// CHECK-LABEL: @test_svqxtnb_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sqxtnb.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svqxtnb_s32u11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sqxtnb.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svint16_t test_svqxtnb_s32(svint32_t op1)
{
  // overload-warning@+2 {{implicit declaration of function 'svqxtnb'}}
  // expected-warning@+1 {{implicit declaration of function 'svqxtnb_s32'}}
  return SVE_ACLE_FUNC(svqxtnb,_s32,,)(op1);
}

// CHECK-LABEL: @test_svqxtnb_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sqxtnb.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svqxtnb_s64u11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sqxtnb.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svint32_t test_svqxtnb_s64(svint64_t op1)
{
  // overload-warning@+2 {{implicit declaration of function 'svqxtnb'}}
  // expected-warning@+1 {{implicit declaration of function 'svqxtnb_s64'}}
  return SVE_ACLE_FUNC(svqxtnb,_s64,,)(op1);
}

// CHECK-LABEL: @test_svqxtnb_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.uqxtnb.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svqxtnb_u16u12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.uqxtnb.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svqxtnb_u16(svuint16_t op1)
{
  // overload-warning@+2 {{implicit declaration of function 'svqxtnb'}}
  // expected-warning@+1 {{implicit declaration of function 'svqxtnb_u16'}}
  return SVE_ACLE_FUNC(svqxtnb,_u16,,)(op1);
}

// CHECK-LABEL: @test_svqxtnb_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.uqxtnb.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svqxtnb_u32u12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.uqxtnb.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svuint16_t test_svqxtnb_u32(svuint32_t op1)
{
  // overload-warning@+2 {{implicit declaration of function 'svqxtnb'}}
  // expected-warning@+1 {{implicit declaration of function 'svqxtnb_u32'}}
  return SVE_ACLE_FUNC(svqxtnb,_u32,,)(op1);
}

// CHECK-LABEL: @test_svqxtnb_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.uqxtnb.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svqxtnb_u64u12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.uqxtnb.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svuint32_t test_svqxtnb_u64(svuint64_t op1)
{
  // overload-warning@+2 {{implicit declaration of function 'svqxtnb'}}
  // expected-warning@+1 {{implicit declaration of function 'svqxtnb_u64'}}
  return SVE_ACLE_FUNC(svqxtnb,_u64,,)(op1);
}
