# ===----------------------------------------------------------------------=== #
#
# This file is Modular Inc proprietary.
#
# ===----------------------------------------------------------------------=== #
# RUN: %mojo -debug-level full %s | FileCheck %s

from sys.info import (
    alignof,
    num_logical_cores,
    num_performance_cores,
    num_physical_cores,
    sizeof,
)


# CHECK-LABEL: test_sizeof
fn test_sizeof():
    print("== test_sizeof")

    # CHECK: 2
    print(sizeof[__mlir_type.i16]())

    # CHECK: 2
    print(sizeof[__mlir_type.ui16]())

    # CHECK: 2
    print(sizeof[DType.int16]())

    # CHECK: 2
    print(sizeof[DType.uint16]())

    # CHECK: 4
    print(sizeof[SIMD[DType.int16, 2]]())


# CHECK-LABEL: test_alignof
fn test_alignof():
    print("== test_alignof")

    # CHECK: True
    print(alignof[__mlir_type.i16]() > 0)

    # CHECK: True
    print(alignof[__mlir_type.ui16]() > 0)

    # CHECK: True
    print(alignof[DType.int16]() > 0)

    # CHECK: True
    print(alignof[DType.uint16]() > 0)

    # CHECK: True
    print(alignof[SIMD[DType.int16, 2]]() > 0)


fn test_cores():
    # CHECK: True
    print(num_logical_cores() > 0)
    # CHECK: True
    print(num_physical_cores() > 0)
    # CHECK: True
    print(num_performance_cores() > 0)


fn main():
    test_sizeof()
    test_alignof()
    test_cores()
