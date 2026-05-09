//
//  RegisterViewModelTests.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/9/26.
//

import XCTest
@testable import Vitesse

@MainActor
final class RegisterViewModelTests: XCTestCase {
    
    // register success
    func test_register_setsRegistrationSuccessful_whenAccountCreationSucceeds() async {
        let repository = MockAuthRepository()
        
        let viewModel = RegisterViewModel(authRepository: repository)
        
        let formData = RegisterFormData(
            firstName: "John",
            lastName: "Lejay",
            email: "test@example.com",
            password: "password"
        )
        
        await viewModel.register(
            formData: formData,
            confirmPassword: "password"
        )
        
        XCTAssertTrue(viewModel.isRegistrationSuccessful)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // register failure
    func test_register_setsErrorMessage_whenAccountCreationFails() async {
        let repository = MockAuthRepository()
        repository.error = APIError.invalidStatusCode(
            500,
            message: "UNIQUE constraint failed: users.email"
        )
        
        let viewModel = RegisterViewModel(authRepository: repository)
        
        let formData = RegisterFormData(
            firstName: "John",
            lastName: "Lejay",
            email: "test@example.com",
            password: "password"
        )
        
        await viewModel.register(
            formData: formData,
            confirmPassword: "password"
        )
        
        XCTAssertFalse(viewModel.isRegistrationSuccessful)
        XCTAssertEqual(viewModel.errorMessage, "UNIQUE constraint failed: users.email")
    }
    
    // passwords mismatch
    func test_register_setsErrorMessage_whenPasswordsDoNotMatch() async {
        let repository = MockAuthRepository()
        
        let viewModel = RegisterViewModel(authRepository: repository)
        
        let formData = RegisterFormData(
            firstName: "John",
            lastName: "Lejay",
            email: "test@example.com",
            password: "password"
        )
        
        await viewModel.register(
            formData: formData,
            confirmPassword: "different-password"
        )
        
        XCTAssertFalse(viewModel.isRegistrationSuccessful)
        XCTAssertEqual(viewModel.errorMessage, "Passwords do not match")
        XCTAssertFalse(repository.createAccountWasCalled)
    }
    
}
