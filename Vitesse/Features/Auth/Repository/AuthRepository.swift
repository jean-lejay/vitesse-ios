//
//  AuthRepository.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.
//

import Foundation

final class AuthRepository: AuthRepositoryProtocol {
    
    private let apiClient: APIClientProtocol
    private let baseURL = "http://127.0.0.1:8080/user"
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func authenticate(email: String, password: String) async throws -> String {
        
        let authDetails = AuthRequestDTO(email: email, password: password)
        
        let authResponse: AuthResponse = try await apiClient.performRequest(urlString: "\(baseURL)/auth", method: .post, token: nil, body: authDetails, expectedStatusCode: 200)
        
        return authResponse.token
        
    }

    func createAccount(request: RegisterUserRequestDTO) async throws {
        let _: EmptyResponse = try await apiClient.performRequest(urlString: "\(baseURL)/register", method: .post, token: nil, body: request, expectedStatusCode: 201)
    }

}
