//
//  RequestManager.swift
//  BaseProject
//
//  Created by Tyler on 2023-06-26.
//

import Foundation

protocol RequestManagerProtocol {
  var apiManager: APIManagerProtocol { get }
  var parser: DataParserProtocol { get }
  func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T
}


class RequestManager: RequestManagerProtocol {
  let apiManager: APIManagerProtocol

  init(
    apiManager: APIManagerProtocol = APIManager()
  ) {
    self.apiManager = apiManager
  }

  func requestAccessToken() async throws -> String {

    let data = try await apiManager.initRequest(with: AuthTokenRequest.auth, authToken: "")
    let token: APIToken = try parser.parse(data: data)
    return token.bearerAccessToken
  }

  func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T {
    let authToken = try await requestAccessToken()
    let data = try await apiManager.initRequest(with: data, authToken: authToken)
    let decoded: T = try parser.parse(data: data)
    return decoded
  }
}

// MARK: - Returns Data Parser
extension RequestManagerProtocol {
  var parser: DataParserProtocol {
    return DataParser()
  }
}
