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
    
    func login(with token: String) {
        self.token = token
    }
    
    func logout() {
        token = nil
    }
}
