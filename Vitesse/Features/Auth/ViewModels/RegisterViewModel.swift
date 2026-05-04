//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

import Foundation
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {
    
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading = false
    @Published private(set) var isRegistrationSuccessful = false
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
 
    func register(formData: RegisterFormData) async {
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
            
        } catch APIError.invalidStatusCode(_, let message) {
            errorMessage = message ?? "Account creation failed"
        } catch {
            errorMessage = "Account creation failed"
        }
        
    }
    
}
