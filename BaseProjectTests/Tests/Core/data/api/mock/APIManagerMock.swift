//
//  APIManagerMock.swift
//  BaseProject
//
//  Created by Tyler on 2023-09-05.
//

@testable import BaseProject

struct APIManagerMock: APIManagerProtocol {
  func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
    return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
  }
  
  func requestToken() async throws -> Data {
    
  }
}


