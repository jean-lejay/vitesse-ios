//
//  AuthRepositoryProtocol.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/4/26.
//

protocol AuthRepositoryProtocol {
    func authenticate(email: String, password: String) async throws -> String
    func createAccount(request: RegisterUserRequestDTO) async throws
}

