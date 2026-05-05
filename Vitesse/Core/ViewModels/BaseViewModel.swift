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
}
