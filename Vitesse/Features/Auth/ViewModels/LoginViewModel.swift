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
    
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading = false
    
    private let authRepository: AuthRepositoryProtocol
    private let session: SessionViewModel
    
    init(authRepository: AuthRepositoryProtocol, session: SessionViewModel) {
        self.authRepository = authRepository
        self.session = session
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil // reset avant la requête
        session.logout()
        
        defer {
            isLoading = false
        }
        
        do {
            let token = try await authRepository.authenticate(email: email, password: password)
            session.login(with: token)
            
        } catch APIError.invalidStatusCode(_, let message) {
            errorMessage = message ?? "Unable to log in"
        } catch {
            errorMessage = "Unable to log in"
        }
        
    }

}

