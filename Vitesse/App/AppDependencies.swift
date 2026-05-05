//
//  AppDependencies.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/5/26.
//

import Foundation

final class AppDependencies {
    let authRepository: AuthRepositoryProtocol
    let candidateRepository: CandidateRepositoryProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.authRepository = AuthRepository(apiClient: apiClient)
        self.candidateRepository = CandidateRepository(apiClient: apiClient)
    }
}
