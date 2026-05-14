//
//  AuthRepositoryTests.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/8/26.
//

import XCTest
@testable import Vitesse

@MainActor
final class AuthRepositoryTests: XCTestCase {
    
    // MARK: - authenticate
    
    // success : authenticate returns AuthResponse
    
    func test_authenticate_returnsAuthResponse() async throws {
        let apiClient = MockAPIClient()
        apiClient.result = AuthResponse(
            token: "fake-token",
            isAdmin: true
        )
        
        let repository = AuthRepository(apiClient: apiClient)
        
        let response = try await repository.authenticate(
            email: "test@example.com",
            password: "password"
        )
        
        XCTAssertEqual(response.token, "fake-token")
        XCTAssertTrue(response.isAdmin)
    }
    
    // failure : authenticate throws when APIClient fails (401: Unauthorized)
    func test_authenticate_throwsError_whenAPIClientFails() async {
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(401, message: "Invalid credentials")
        
        let repository = AuthRepository(apiClient: apiClient)
        
        do {
            _ = try await repository.authenticate(
                email: "test@example.com",
                password: "password"
            )
            XCTFail("Expected authenticate to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - createAccount
    
    func test_createAccount_succeeds_whenAPIClientSucceeds() async throws {
        let apiClient = MockAPIClient()
        apiClient.result = EmptyResponse()
        
        let repository = AuthRepository(apiClient: apiClient)
        
        let request = RegisterUserRequestDTO(firstName: "John", lastName: "Lejeune", email: "test@example.com", password: "password")
        
        try await repository.createAccount(request: request)
    }
    
    func test_createAccount_throwsError_whenAPIClientFails() async {
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(500, message: "UNIQUE constraint failed: users.email")
        
        let repository = AuthRepository(apiClient: apiClient)
        
        let request = RegisterUserRequestDTO(firstName: "John", lastName: "Lejeune", email: "test@example.com", password: "password")
        
        do {
            _ = try await repository.createAccount(request: request)
            XCTFail("Expected authenticate to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }

}
