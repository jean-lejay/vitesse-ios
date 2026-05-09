//
//  LoginViewModelTests.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/9/26.
//

import XCTest
@testable import Vitesse

@MainActor
final class LoginViewModelTests: XCTestCase {

    // login success
    func test_login_updatesSession_whenAuthenticationSucceeds() async {
        let repository = MockAuthRepository()
        repository.authResponse = AuthResponse(
            token: "fake-token",
            isAdmin: true
        )
        
        let session = SessionViewModel()
        
        let viewModel = LoginViewModel(
            authRepository: repository,
            session: session
        )
        
        await viewModel.login(
            email: "test@example.com",
            password: "password"
        )
        
        XCTAssertEqual(session.token, "fake-token")
        XCTAssertTrue(session.isAdmin)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // login failure
    func test_login_setsErrorMessage_whenAuthenticationFails() async {
        let repository = MockAuthRepository()
        repository.error = APIError.invalidStatusCode(
            401,
            message: "Invalid credentials"
        )
        
        let session = SessionViewModel()
        
        let viewModel = LoginViewModel(
            authRepository: repository,
            session: session
        )
        
        await viewModel.login(
            email: "test@example.com",
            password: "wrong-password"
        )
        
        XCTAssertNil(session.token)
        XCTAssertFalse(session.isAuthenticated)
        XCTAssertEqual(viewModel.errorMessage, "Invalid credentials")
    }
    
    // invalid email
    func test_login_setsErrorMessage_whenEmailIsInvalid() async {
        let repository = MockAuthRepository()
        let session = SessionViewModel()
        
        let viewModel = LoginViewModel(
            authRepository: repository,
            session: session
        )
        
        await viewModel.login(
            email: "invalid-email",
            password: "password"
        )
        
        XCTAssertNil(session.token)
        XCTAssertFalse(session.isAuthenticated)
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid email address")
        XCTAssertFalse(repository.authenticateWasCalled)
    }
}
