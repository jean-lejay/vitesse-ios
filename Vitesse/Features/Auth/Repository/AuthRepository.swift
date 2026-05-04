//
//  AuthRepository.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.
//

import Foundation

final class AuthRepository {
    
    private let apiClient = APIClient()
    
    private let baseURL = "http://127.0.0.1:8080/user"
 
    func authenticate(email: String, password: String) async throws -> String {
        
        let authDetails = AuthRequestDTO(email: email, password: password)
        
        let authResponse: AuthResponse = try await apiClient.performRequest(urlString: "\(baseURL)/auth", method: .post, body: authDetails, expectedStatusCode: 200)
        
        return authResponse.token
        
    }

    func createAccount(candidateDetail: RegisterUserRequestDTO) async throws {
        let _: EmptyResponse = try await apiClient.performRequest(urlString: "\(baseURL)/register", method: .post, body: candidateDetail, expectedStatusCode: 201)
    }

}
