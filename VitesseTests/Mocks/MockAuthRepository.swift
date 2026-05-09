//
//  MockAuthRepository.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/9/26.
//

import Foundation
@testable import Vitesse

final class MockAuthRepository: AuthRepositoryProtocol {
    
    var authResponse: AuthResponse?
    var error: Error?
    var authenticateWasCalled = false
    var createAccountWasCalled = false
    
    func authenticate(email: String, password: String) async throws -> AuthResponse {
        authenticateWasCalled = true
        
        if let error {
            throw error
        }
        
        guard let authResponse else {
            fatalError("Mock authResponse not configured")
        }
        
        return authResponse
    }

    func createAccount(request: RegisterUserRequestDTO) async throws {
        createAccountWasCalled = true
        
        if let error {
            throw error
        }
    }
}
