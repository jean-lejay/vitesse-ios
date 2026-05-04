//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/29/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var token: String?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let authRepository = AuthRepository()
    
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil // reset avant la requête
        token = nil // reset avant la requête
        
        do {
            token = try await authRepository.authenticate(email: email, password: password)
            
        } catch APIError.invalidStatusCode(_, let message) {
            errorMessage = message ?? "Unable to log in"
        } catch {
            errorMessage = "Unable to log in"
        }
        
        isLoading = false
    }

}

