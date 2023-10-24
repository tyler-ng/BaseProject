//
//  AccessTokenTestHelper.swift
//  BaseProject
//
//  Created by Tyler on 2023-09-05.
//

@testable import BaseProject

enum AccessTokenTestHelper {
  static func randomString() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyz"
    return String(letters.shuffled().prefix(8))
  }
}
