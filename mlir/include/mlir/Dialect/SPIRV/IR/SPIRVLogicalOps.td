//===-- SPIRVLogicalOps.td - MLIR SPIR-V Logical Ops -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains arithmetic ops for the SPIR-V dialect. It corresponds
// to "3.32.15. Relational and Logical Instructions" of the SPIR-V spec.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_SPIRV_IR_LOGICAL_OPS
#define MLIR_DIALECT_SPIRV_IR_LOGICAL_OPS

include "mlir/Dialect/SPIRV/IR/SPIRVBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

class SPIRV_LogicalBinaryOp<string mnemonic, Type operandsType,
                            list<Trait> traits = []> :
      // Result type is SPIRV_Bool.
      SPIRV_BinaryOp<mnemonic, SPIRV_Bool, operandsType,
                   !listconcat(traits, [
                     NoSideEffect, SameTypeOperands,
                     SameOperandsAndResultShape,
                     TypesMatchWith<"type of result to correspond to the `i1` "
                                    "equivalent of the operand",
                                    "operand1", "result",
                                    "getUnaryOpResultType($_self)"
                     >])> {
  let assemblyFormat = "$operand1 `,` $operand2 `:` type($operand1) attr-dict";

  let builders = [
    OpBuilder<(ins "Value":$lhs, "Value":$rhs),
    [{::buildLogicalBinaryOp($_builder, $_state, lhs, rhs);}]>
  ];
}

class SPIRV_LogicalUnaryOp<string mnemonic, Type operandType,
                         list<Trait> traits = []> :
      // Result type is SPIRV_Bool.
      SPIRV_UnaryOp<mnemonic, SPIRV_Bool, operandType,
                  !listconcat(traits, [
                     NoSideEffect, SameTypeOperands, SameOperandsAndResultShape,
                     TypesMatchWith<"type of result to correspond to the `i1` "
                                    "equivalent of the operand",
                                    "operand", "result",
                                    "getUnaryOpResultType($_self)"
                     >])> {
  let assemblyFormat = "$operand `:` type($operand) attr-dict";

  let builders = [
    OpBuilder<(ins "Value":$value),
    [{::buildLogicalUnaryOp($_builder, $_state, value);}]>
  ];
}

// -----

def SPIRV_FOrdEqualOp : SPIRV_LogicalBinaryOp<"FOrdEqual", SPIRV_Float, [Commutative]> {
  let summary = "Floating-point comparison for being ordered and equal.";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    fordequal-op ::= ssa-id `=` `spirv.FOrdEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FOrdEqual %0, %1 : f32
    %5 = spirv.FOrdEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FOrdGreaterThanOp : SPIRV_LogicalBinaryOp<"FOrdGreaterThan", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are ordered and Operand 1 is
    greater than  Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    fordgt-op ::= ssa-id `=` `spirv.FOrdGreaterThan` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FOrdGreaterThan %0, %1 : f32
    %5 = spirv.FOrdGreaterThan %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FOrdGreaterThanEqualOp : SPIRV_LogicalBinaryOp<"FOrdGreaterThanEqual", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are ordered and Operand 1 is
    greater than or equal to Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    fordgte-op ::= ssa-id `=` `spirv.FOrdGreaterThanEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FOrdGreaterThanEqual %0, %1 : f32
    %5 = spirv.FOrdGreaterThanEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FOrdLessThanOp : SPIRV_LogicalBinaryOp<"FOrdLessThan", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are ordered and Operand 1 is less
    than Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    fordlt-op ::= ssa-id `=` `spirv.FOrdLessThan` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FOrdLessThan %0, %1 : f32
    %5 = spirv.FOrdLessThan %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FOrdLessThanEqualOp : SPIRV_LogicalBinaryOp<"FOrdLessThanEqual", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are ordered and Operand 1 is less
    than or equal to Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    fordlte-op ::= ssa-id `=` `spirv.FOrdLessThanEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FOrdLessThanEqual %0, %1 : f32
    %5 = spirv.FOrdLessThanEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FOrdNotEqualOp : SPIRV_LogicalBinaryOp<"FOrdNotEqual", SPIRV_Float, [Commutative]> {
  let summary = "Floating-point comparison for being ordered and not equal.";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    fordneq-op ::= ssa-id `=` `spirv.FOrdNotEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FOrdNotEqual %0, %1 : f32
    %5 = spirv.FOrdNotEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FUnordEqualOp : SPIRV_LogicalBinaryOp<"FUnordEqual", SPIRV_Float, [Commutative]> {
  let summary = "Floating-point comparison for being unordered or equal.";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    funordequal-op ::= ssa-id `=` `spirv.FUnordEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FUnordEqual %0, %1 : f32
    %5 = spirv.FUnordEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FUnordGreaterThanOp : SPIRV_LogicalBinaryOp<"FUnordGreaterThan", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are unordered or Operand 1 is
    greater than  Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    funordgt-op ::= ssa-id `=` `spirv.FUnordGreaterThan` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FUnordGreaterThan %0, %1 : f32
    %5 = spirv.FUnordGreaterThan %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FUnordGreaterThanEqualOp : SPIRV_LogicalBinaryOp<"FUnordGreaterThanEqual", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are unordered or Operand 1 is
    greater than or equal to Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    funordgte-op ::= ssa-id `=` `spirv.FUnordGreaterThanEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FUnordGreaterThanEqual %0, %1 : f32
    %5 = spirv.FUnordGreaterThanEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FUnordLessThanOp : SPIRV_LogicalBinaryOp<"FUnordLessThan", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are unordered or Operand 1 is less
    than Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    funordlt-op ::= ssa-id `=` `spirv.FUnordLessThan` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FUnordLessThan %0, %1 : f32
    %5 = spirv.FUnordLessThan %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FUnordLessThanEqualOp : SPIRV_LogicalBinaryOp<"FUnordLessThanEqual", SPIRV_Float, []> {
  let summary = [{
    Floating-point comparison if operands are unordered or Operand 1 is less
    than or equal to Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    funordlte-op ::= ssa-id `=` `spirv.FUnordLessThanEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FUnordLessThanEqual %0, %1 : f32
    %5 = spirv.FUnordLessThanEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_FUnordNotEqualOp : SPIRV_LogicalBinaryOp<"FUnordNotEqual", SPIRV_Float, [Commutative]> {
  let summary = "Floating-point comparison for being unordered or not equal.";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    floating-point type.  They must have the same type, and they must have
    the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    funordneq-op ::= ssa-id `=` `spirv.FUnordNotEqual` ssa-use, ssa-use
    ```

    #### Example:

    ```mlir
    %4 = spirv.FUnordNotEqual %0, %1 : f32
    %5 = spirv.FUnordNotEqual %2, %3 : vector<4xf32>
    ```
  }];
}

// -----

def SPIRV_IEqualOp : SPIRV_LogicalBinaryOp<"IEqual",
                                       SPIRV_Integer,
                                       [Commutative, UsableInSpecConstantOp]> {
  let summary = "Integer comparison for equality.";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    iequal-op ::= ssa-id `=` `spirv.IEqual` ssa-use, ssa-use
                             `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.IEqual %0, %1 : i32
    %5 = spirv.IEqual %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_INotEqualOp : SPIRV_LogicalBinaryOp<"INotEqual",
                                          SPIRV_Integer,
                                          [Commutative, UsableInSpecConstantOp]> {
  let summary = "Integer comparison for inequality.";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    inot-equal-op ::= ssa-id `=` `spirv.INotEqual` ssa-use, ssa-use
                                 `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.INotEqual %0, %1 : i32
    %5 = spirv.INotEqual %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_IsInfOp : SPIRV_LogicalUnaryOp<"IsInf", SPIRV_Float, []> {
  let summary = "Result is true if x is an IEEE Inf, otherwise result is false";

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

    x must be a scalar or vector of floating-point type.  It must have the
    same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    isinf-op ::= ssa-id `=` `spirv.IsInf` ssa-use
                            `:` float-scalar-vector-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.IsInf %0: f32
    %3 = spirv.IsInf %1: vector<4xi32>
    ```
  }];
}

// -----

def SPIRV_IsNanOp : SPIRV_LogicalUnaryOp<"IsNan", SPIRV_Float, []> {
  let summary = [{
    Result is true if x is an IEEE NaN, otherwise result is false.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

    x must be a scalar or vector of floating-point type.  It must have the
    same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    isnan-op ::= ssa-id `=` `spirv.IsNan` ssa-use
                            `:` float-scalar-vector-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.IsNan %0: f32
    %3 = spirv.IsNan %1: vector<4xi32>
    ```
  }];
}

// -----

def SPIRV_LogicalAndOp : SPIRV_LogicalBinaryOp<"LogicalAnd",
                                           SPIRV_Bool,
                                           [Commutative,
                                            UsableInSpecConstantOp]> {
  let summary = [{
    Result is true if both Operand 1 and Operand 2 are true. Result is false
    if either Operand 1 or Operand 2 are false.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 must be the same as Result Type.

     The type of Operand 2 must be the same as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    logical-and ::= `spirv.LogicalAnd` ssa-use `,` ssa-use
                    `:` operand-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.LogicalAnd %0, %1 : i1
    %2 = spirv.LogicalAnd %0, %1 : vector<4xi1>
    ```
  }];

  let hasFolder = 1;
}

// -----

def SPIRV_LogicalEqualOp : SPIRV_LogicalBinaryOp<"LogicalEqual",
                                             SPIRV_Bool,
                                             [Commutative,
                                              UsableInSpecConstantOp]> {
  let summary = [{
    Result is true if Operand 1 and Operand 2 have the same value. Result is
    false if Operand 1 and Operand 2 have different values.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 must be the same as Result Type.

     The type of Operand 2 must be the same as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    logical-equal ::= `spirv.LogicalEqual` ssa-use `,` ssa-use
                      `:` operand-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.LogicalEqual %0, %1 : i1
    %2 = spirv.LogicalEqual %0, %1 : vector<4xi1>
    ```
  }];
}

// -----

def SPIRV_LogicalNotOp : SPIRV_LogicalUnaryOp<"LogicalNot",
                                          SPIRV_Bool,
                                          [UsableInSpecConstantOp]> {
  let summary = [{
    Result is true if Operand is false.  Result is false if Operand is true.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand must be the same as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    logical-not ::= `spirv.LogicalNot` ssa-use `:` operand-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.LogicalNot %0 : i1
    %2 = spirv.LogicalNot %0 : vector<4xi1>
    ```
  }];

  let hasCanonicalizer = 1;
}

// -----

def SPIRV_LogicalNotEqualOp : SPIRV_LogicalBinaryOp<"LogicalNotEqual",
                                                SPIRV_Bool,
                                                [Commutative,
                                                 UsableInSpecConstantOp]> {
  let summary = [{
    Result is true if Operand 1 and Operand 2 have different values. Result
    is false if Operand 1 and Operand 2 have the same value.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 must be the same as Result Type.

     The type of Operand 2 must be the same as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    logical-not-equal ::= `spirv.LogicalNotEqual` ssa-use `,` ssa-use
                          `:` operand-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.LogicalNotEqual %0, %1 : i1
    %2 = spirv.LogicalNotEqual %0, %1 : vector<4xi1>
    ```
  }];
}

// -----

def SPIRV_LogicalOrOp : SPIRV_LogicalBinaryOp<"LogicalOr",
                                          SPIRV_Bool,
                                          [Commutative,
                                           UsableInSpecConstantOp]> {
  let summary = [{
    Result is true if either Operand 1 or Operand 2 is true. Result is false
    if both Operand 1 and Operand 2 are false.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 must be the same as Result Type.

     The type of Operand 2 must be the same as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    logical-or ::= `spirv.LogicalOr` ssa-use `,` ssa-use
                    `:` operand-type
    ```

    #### Example:

    ```mlir
    %2 = spirv.LogicalOr %0, %1 : i1
    %2 = spirv.LogicalOr %0, %1 : vector<4xi1>
    ```
  }];

  let hasFolder = 1;
}

// -----

def SPIRV_OrderedOp : SPIRV_LogicalBinaryOp<"Ordered", SPIRV_Float, [Commutative]> {
  let summary = [{
    Result is true if both x == x and y == y are true, where IEEE comparison
    is used, otherwise result is false.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

    x must be a scalar or vector of floating-point type.  It must have the
    same number of components as Result Type.

    y must have the same type as x.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    ordered-op ::= ssa-id `=` `spirv.Ordered` ssa-use, ssa-use
    ```mlir

    #### Example:

    ```
    %4 = spirv.Ordered %0, %1 : f32
    %5 = spirv.Ordered %2, %3 : vector<4xf32>
    ```
  }];

  let availability = [
    MinVersion<SPIRV_V_1_0>,
    MaxVersion<SPIRV_V_1_6>,
    Extension<[]>,
    Capability<[SPIRV_C_Kernel]>
  ];
}

// -----

def SPIRV_SGreaterThanOp : SPIRV_LogicalBinaryOp<"SGreaterThan",
                                             SPIRV_Integer,
                                             [UsableInSpecConstantOp, SignedOp]> {
  let summary = [{
    Signed-integer comparison if Operand 1 is greater than  Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    sgreater-than-op ::= ssa-id `=` `spirv.SGreaterThan` ssa-use, ssa-use
                                    `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.SGreaterThan %0, %1 : i32
    %5 = spirv.SGreaterThan %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_SGreaterThanEqualOp : SPIRV_LogicalBinaryOp<"SGreaterThanEqual",
                                                  SPIRV_Integer,
                                                  [UsableInSpecConstantOp,
                                                   SignedOp]> {
  let summary = [{
    Signed-integer comparison if Operand 1 is greater than or equal to
    Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    sgreater-than-equal-op ::= ssa-id `=` `spirv.SGreaterThanEqual` ssa-use, ssa-use
                                          `:` integer-scalar-vector-type
    ```
    #### Example:

    ```
    %4 = spirv.SGreaterThanEqual %0, %1 : i32
    %5 = spirv.SGreaterThanEqual %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_SLessThanOp : SPIRV_LogicalBinaryOp<"SLessThan",
                                          SPIRV_Integer,
                                          [UsableInSpecConstantOp, SignedOp]> {
  let summary = [{
    Signed-integer comparison if Operand 1 is less than Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    sless-than-op ::= ssa-id `=` `spirv.SLessThan` ssa-use, ssa-use
                                 `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.SLessThan %0, %1 : i32
    %5 = spirv.SLessThan %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_SLessThanEqualOp : SPIRV_LogicalBinaryOp<"SLessThanEqual",
                                               SPIRV_Integer,
                                               [UsableInSpecConstantOp,
                                                SignedOp]> {
  let summary = [{
    Signed-integer comparison if Operand 1 is less than or equal to Operand
    2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    sless-than-equal-op ::= ssa-id `=` `spirv.SLessThanEqual` ssa-use, ssa-use
                                       `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.SLessThanEqual %0, %1 : i32
    %5 = spirv.SLessThanEqual %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_SelectOp : SPIRV_Op<"Select",
    [NoSideEffect,
     AllTypesMatch<["true_value", "false_value", "result"]>,
     UsableInSpecConstantOp]> {
  let summary = [{
    Select between two objects. Before version 1.4, results are only
    computed per component.
  }];

  let description = [{
    Before version 1.4, Result Type must be a pointer, scalar, or vector.

     The types of Object 1 and Object 2 must be the same as Result Type.

    Condition must be a scalar or vector of Boolean type.

    If Condition is a scalar and true, the result is Object 1. If Condition
    is a scalar and false, the result is Object 2.

    If Condition is a vector, Result Type must be a vector with the same
    number of components as Condition and the result is a mix of Object 1
    and Object 2: When a component of Condition is true, the corresponding
    component in the result is taken from Object 1, otherwise it is taken
    from Object 2.

    <!-- End of AutoGen section -->

    ```
    scalar-type ::= integer-type | float-type | boolean-type
    select-object-type ::= scalar-type
                           | `vector<` integer-literal `x` scalar-type `>`
                           | pointer-type
    select-condition-type ::= boolean-type
                              | `vector<` integer-literal `x` boolean-type `>`
    select-op ::= ssa-id `=` `spirv.Select` ssa-use, ssa-use, ssa-use
                  `:` select-condition-type `,` select-object-type
    ```

    #### Example:

    ```mlir
    %3 = spirv.Select %0, %1, %2 : i1, f32
    %3 = spirv.Select %0, %1, %2 : i1, vector<3xi32>
    %3 = spirv.Select %0, %1, %2 : vector<3xi1>, vector<3xf32>
    ```
  }];

  let arguments = (ins
    SPIRV_ScalarOrVectorOf<SPIRV_Bool>:$condition,
    SPIRV_SelectType:$true_value,
    SPIRV_SelectType:$false_value
  );

  let results = (outs
    SPIRV_SelectType:$result
  );

  let assemblyFormat = [{
    operands attr-dict `:` type($condition) `,` type($result)
  }];
}

// -----

def SPIRV_UGreaterThanOp : SPIRV_LogicalBinaryOp<"UGreaterThan",
                                             SPIRV_Integer,
                                             [UnsignedOp,
                                              UsableInSpecConstantOp]> {
  let summary = [{
    Unsigned-integer comparison if Operand 1 is greater than  Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    ugreater-than-op ::= ssa-id `=` `spirv.UGreaterThan` ssa-use, ssa-use
                                    `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.UGreaterThan %0, %1 : i32
    %5 = spirv.UGreaterThan %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_UGreaterThanEqualOp : SPIRV_LogicalBinaryOp<"UGreaterThanEqual",
                                                  SPIRV_Integer,
                                                  [UnsignedOp,
                                                   UsableInSpecConstantOp]> {
  let summary = [{
    Unsigned-integer comparison if Operand 1 is greater than or equal to
    Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    ugreater-than-equal-op ::= ssa-id `=` `spirv.UGreaterThanEqual` ssa-use, ssa-use
                                          `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.UGreaterThanEqual %0, %1 : i32
    %5 = spirv.UGreaterThanEqual %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_ULessThanOp : SPIRV_LogicalBinaryOp<"ULessThan",
                                          SPIRV_Integer,
                                          [UnsignedOp, UsableInSpecConstantOp]> {
  let summary = [{
    Unsigned-integer comparison if Operand 1 is less than Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    uless-than-op ::= ssa-id `=` `spirv.ULessThan` ssa-use, ssa-use
                                 `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.ULessThan %0, %1 : i32
    %5 = spirv.ULessThan %2, %3 : vector<4xi32>

    ```
  }];
}

// -----

def SPIRV_UnorderedOp : SPIRV_LogicalBinaryOp<"Unordered", SPIRV_Float, [Commutative]> {
  let summary = [{
    Result is true if either x or y is an IEEE NaN, otherwise result is
    false.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

    x must be a scalar or vector of floating-point type.  It must have the
    same number of components as Result Type.

    y must have the same type as x.

     Results are computed per component.

    <!-- End of AutoGen section -->

    ```
    float-scalar-vector-type ::= float-type |
                                 `vector<` integer-literal `x` float-type `>`
    unordered-op ::= ssa-id `=` `spirv.Unordered` ssa-use, ssa-use
    ```mlir

    #### Example:

    ```
    %4 = spirv.Unordered %0, %1 : f32
    %5 = spirv.Unordered %2, %3 : vector<4xf32>
    ```
  }];

  let availability = [
    MinVersion<SPIRV_V_1_0>,
    MaxVersion<SPIRV_V_1_6>,
    Extension<[]>,
    Capability<[SPIRV_C_Kernel]>
  ];
}

// -----

def SPIRV_ULessThanEqualOp : SPIRV_LogicalBinaryOp<"ULessThanEqual",
                                               SPIRV_Integer,
                                               [UnsignedOp,
                                                UsableInSpecConstantOp]> {
  let summary = [{
    Unsigned-integer comparison if Operand 1 is less than or equal to
    Operand 2.
  }];

  let description = [{
    Result Type must be a scalar or vector of Boolean type.

     The type of Operand 1 and Operand 2  must be a scalar or vector of
    integer type.  They must have the same component width, and they must
    have the same number of components as Result Type.

     Results are computed per component.

    <!-- End of AutoGen section -->
    ```
    integer-scalar-vector-type ::= integer-type |
                                 `vector<` integer-literal `x` integer-type `>`
    uless-than-equal-op ::= ssa-id `=` `spirv.ULessThanEqual` ssa-use, ssa-use
                                       `:` integer-scalar-vector-type
    ```
    #### Example:

    ```mlir
    %4 = spirv.ULessThanEqual %0, %1 : i32
    %5 = spirv.ULessThanEqual %2, %3 : vector<4xi32>

    ```
  }];
}

#endif // MLIR_DIALECT_SPIRV_IR_LOGICAL_OPS
