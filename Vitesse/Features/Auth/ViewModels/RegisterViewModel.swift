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
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let authRepository = AuthRepository()
 
    func register(candidateDetail: RegisterUserRequestDTO) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await authRepository.createAccount(candidateDetail: candidateDetail)
            
        } catch APIError.invalidStatusCode(_, let message) {
            errorMessage = message ?? "Account creation failed"
        } catch {
            errorMessage = "Account creation failed"
        }
        isLoading = false
    }
    
}
