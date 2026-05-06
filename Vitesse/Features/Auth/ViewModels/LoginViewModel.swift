//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/29/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: BaseViewModel {
    
    private let authRepository: AuthRepositoryProtocol
    private let session: SessionViewModel
    
    init(authRepository: AuthRepositoryProtocol, session: SessionViewModel) {
        self.authRepository = authRepository
        self.session = session
    }
    
    func login(email: String, password: String) async {
        
        guard isEmailValid(email) else {
            errorMessage = "Please enter a valid email address"
            return
        }
        
        isLoading = true
        errorMessage = nil
        session.logout()
        
        defer {
            isLoading = false
        }
        
        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)
            
            let token = try await authRepository.authenticate(email: email, password: password)
            session.login(with: token)
            
        } catch {
            handleError(error, defaultMessage: "Unable to log in")
        }
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let regex = /^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/
        return email.wholeMatch(of: regex) != nil
    }
    
    func startEditingEmail() {
        errorMessage = nil
    }
    
    func validateEmail(_ email: String) {
        if !isEmailValid(email) {
            errorMessage = "Please enter a valid email address"
        }
    }
    
    func canSubmit(email: String, password: String) -> Bool {
        isEmailValid(email) && !password.isEmpty
    }
}
