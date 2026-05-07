//
//  BaseViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/5/26.
//

import Foundation
import Combine

@MainActor
class BaseViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func handleError(_ error: Error, defaultMessage: String) {
        switch error {
        case APIError.invalidStatusCode(_, let message):
            errorMessage = message ?? defaultMessage
        default:
            errorMessage = defaultMessage
        }
    }
    
    // Pour les vues Login et Register
    
    func isEmailValid(_ email: String) -> Bool {
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
}
