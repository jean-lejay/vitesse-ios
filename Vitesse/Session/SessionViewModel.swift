//
//  SessionViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/4/26.
//

import Foundation
import Combine

// gestion du token

@MainActor
final class SessionViewModel: ObservableObject {
    
    @Published private(set) var token: String?
    @Published private(set) var isAdmin = false
    
    var isAuthenticated: Bool {
        token != nil
    }
    
    func login(token: String, isAdmin: Bool) {
        self.token = token
        self.isAdmin = isAdmin
    }
    
    func logout() {
        token = nil
        isAdmin = false
    }
}
