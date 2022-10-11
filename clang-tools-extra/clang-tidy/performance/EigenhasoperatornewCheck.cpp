//===--- EigenhasoperatornewCheck.cpp - clang-tidy ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "EigenhasoperatornewCheck.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
// #include <iostream>

using namespace clang::ast_matchers;

namespace clang {
namespace tidy {
namespace performance {

void EigenhasoperatornewCheck::registerMatchers(MatchFinder *Finder) {
  //operator new matcher
  const auto opnewDecl = cxxMethodDecl(hasName("operator new")).bind("noopnew");
  const auto eigenmxxfDecl = hasType(asString("Eigen::MatrixXf"));
  const auto eigenmx3fDecl = hasType(asString("Eigen::Matrix3f"));
  const auto eigenmx2fDecl = hasType(asString("Eigen::Matrix2f"));
  const auto eigenmx4fDecl = hasType(asString("Eigen::Matrix4f"));

  const auto eigenmx2dDecl =  hasType(asString("Eigen::Matrix2d"));
  const auto eigenmx3dDecl =  hasType(asString("Eigen::Matrix3d"));
  const auto eigenmx4dDecl =  hasType(asString("Eigen::Matrix4d"));
  const auto eigenmxxdDecl =  hasType(asString("Eigen::MatrixXd"));

  const auto eigenv2fDecl = hasType(asString("Eigen::Vector2f"));
  const auto eigenv3fDecl = hasType(asString("Eigen::Vector3f"));
  const auto eigenv4fDecl = hasType(asString("Eigen::Vector4f"));
  const auto eigenvxfDecl = hasType(asString("Eigen::VectorXf"));

  const auto eigenv2dDecl = hasType(asString("Eigen::Vector2d"));
  const auto eigenv3dDecl = hasType(asString("Eigen::Vector3d"));
  const auto eigenv4dDecl = hasType(asString("Eigen::Vector4d"));
  const auto eigenvxdDecl = hasType(asString("Eigen::VectorXd"));

  // Finder->addMatcher(cxxRecordDecl(isExpansionInMainFile(), allOf(opnewDecl, anyOf(eigenmxxfDecl, eigenmx3fDecl)), this));
  Finder->addMatcher(cxxRecordDecl(isExpansionInMainFile(), anyOf(hasDescendant(opnewDecl), hasDescendant(fieldDecl(anyOf(eigenmxxfDecl, eigenmx3fDecl)).bind("eigen")))).bind("cls"), this);

}

void EigenhasoperatornewCheck::check(const MatchFinder::MatchResult &Result) {
  // FIXME: Add callback implementation.
  const auto *opnewDecl = Result.Nodes.getNodeAs<CXXMethodDecl>("noopnew");
  const auto *eigenDecl = Result.Nodes.getNodeAs<FieldDecl>("eigen");
  if(eigenDecl && !opnewDecl) {

    const auto *objDecl = Result.Nodes.getNodeAs<CXXRecordDecl>("cls");
    diag(objDecl->getLocation(), "class test----fail")
    << objDecl;
  }
}

} // namespace performance
} // namespace tidy
} // namespace clang
