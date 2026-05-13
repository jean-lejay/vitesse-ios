//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

import Foundation
import Combine

@MainActor
final class RegisterViewModel: BaseViewModel {
    
    @Published private(set) var isRegistrationSuccessful = false
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
 
    func register(formData: RegisterFormData, confirmPassword: String) async {
        
        guard isEmailValid(formData.email) else {
            errorMessage = "Please enter a valid email address"
            return
        }
        
        guard formData.password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        isLoading = true
        errorMessage = nil
        isRegistrationSuccessful = false
        
        defer {
            isLoading = false
        }
        
        do {
            let request = formData.toDTO()
            try await authRepository.createAccount(request: request)
            
            isRegistrationSuccessful = true
            
        } catch {
            handleError(error, defaultMessage: "Account creation failed")
        }
    }
    
    func validatePasswords(password: String, confirmPassword: String) {
        guard !password.isEmpty, !confirmPassword.isEmpty else {
            return
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
        } else {
            errorMessage = nil
        }
    }
    
    // tous les champs du formulaire sont renseignés et le format de l'adresse email est valide
    func canSubmit(formData: RegisterFormData, confirmPassword: String) -> Bool {
        !formData.firstName.isEmpty &&
        !formData.lastName.isEmpty &&
        isEmailValid(formData.email) &&
        !formData.password.isEmpty
    }
}


