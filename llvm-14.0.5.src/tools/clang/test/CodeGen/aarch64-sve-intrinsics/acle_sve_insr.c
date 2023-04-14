// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svinsr_n_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.insr.nxv16i8(<vscale x 16 x i8> [[OP1:%.*]], i8 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svinsr_n_s8u10__SVInt8_ta(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.insr.nxv16i8(<vscale x 16 x i8> [[OP1:%.*]], i8 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svinsr_n_s8(svint8_t op1, int8_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_s8,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.insr.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]], i16 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_s16u11__SVInt16_ts(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.insr.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]], i16 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svint16_t test_svinsr_n_s16(svint16_t op1, int16_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_s16,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.insr.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]], i32 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_s32u11__SVInt32_ti(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.insr.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]], i32 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svint32_t test_svinsr_n_s32(svint32_t op1, int32_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_s32,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.insr.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]], i64 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_s64u11__SVInt64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.insr.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]], i64 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svint64_t test_svinsr_n_s64(svint64_t op1, int64_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_s64,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.insr.nxv16i8(<vscale x 16 x i8> [[OP1:%.*]], i8 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svinsr_n_u8u11__SVUint8_th(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.insr.nxv16i8(<vscale x 16 x i8> [[OP1:%.*]], i8 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svinsr_n_u8(svuint8_t op1, uint8_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_u8,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.insr.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]], i16 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_u16u12__SVUint16_tt(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.insr.nxv8i16(<vscale x 8 x i16> [[OP1:%.*]], i16 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svuint16_t test_svinsr_n_u16(svuint16_t op1, uint16_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_u16,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.insr.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]], i32 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_u32u12__SVUint32_tj(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.insr.nxv4i32(<vscale x 4 x i32> [[OP1:%.*]], i32 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svuint32_t test_svinsr_n_u32(svuint32_t op1, uint32_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_u32,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.insr.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]], i64 [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_u64u12__SVUint64_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.insr.nxv2i64(<vscale x 2 x i64> [[OP1:%.*]], i64 [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svuint64_t test_svinsr_n_u64(svuint64_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_u64,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x half> @llvm.aarch64.sve.insr.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], half [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_f16u13__SVFloat16_tDh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x half> @llvm.aarch64.sve.insr.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], half [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svinsr_n_f16(svfloat16_t op1, float16_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_f16,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.aarch64.sve.insr.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], float [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_f32u13__SVFloat32_tf(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.aarch64.sve.insr.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], float [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svinsr_n_f32(svfloat32_t op1, float32_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_f32,,)(op1, op2);
}

// CHECK-LABEL: @test_svinsr_n_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x double> @llvm.aarch64.sve.insr.nxv2f64(<vscale x 2 x double> [[OP1:%.*]], double [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svinsr_n_f64u13__SVFloat64_td(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x double> @llvm.aarch64.sve.insr.nxv2f64(<vscale x 2 x double> [[OP1:%.*]], double [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svinsr_n_f64(svfloat64_t op1, float64_t op2)
{
  return SVE_ACLE_FUNC(svinsr,_n_f64,,)(op1, op2);
}
