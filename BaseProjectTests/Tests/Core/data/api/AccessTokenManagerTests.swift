//
//  AccessTokenManagerTests.swift
//  BaseProjectTests
//
//  Created by Tyler on 2024-04-06.
//

import XCTest
@testable import BaseProject

final class AccessTokenManagerTests: XCTestCase {
    private var accessTokenManager: AccessTokenManagerProtocol?
    let token = AccessTokenTestHelper.randomAPIToken()
    
    override func setUp() {
        super.setUp()
        guard let userDefaults = UserDefaults(suiteName: #file) else {
            return
        }
        userDefaults.removePersistentDomain(forName: #file)
        userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
        userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)

        accessTokenManager = AccessTokenManager(userDefaults: userDefaults)
    }
    
    func testRequestToken() async throws {
        
        guard let token = accessTokenManager?.fetchToken() else {
            XCTFail("Didn't get token from the access token manager")
            return
        }
        
        XCTAssertFalse(token.isEmpty)
    }
    
    func testCachedToken() async throws {
        guard let sameToken = accessTokenManager?.fetchToken() else {
            XCTFail("Didn't get cached token from the access token manager")
            return
        }
        
        XCTAssertEqual(token.bearerAccessToken, sameToken)
    }
    
    func testRefreshToken() async throws {
        let randomToken = AccessTokenTestHelper.randomAPIToken()
        guard let accessTokenManager = accessTokenManager else {
            XCTFail("Access token manager object is nil")
            return
        }
        try accessTokenManager.refreshWith(apiToken: randomToken)
        let fetchedToken = accessTokenManager.fetchToken()
        XCTAssertNotEqual(token.bearerAccessToken, fetchedToken)
        XCTAssertEqual(randomToken.bearerAccessToken, fetchedToken)
    }

}
