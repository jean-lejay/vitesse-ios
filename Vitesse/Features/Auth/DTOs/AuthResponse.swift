//
//  AuthResponse.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.
//

struct AuthResponse: Decodable {
    let token: String
    let isAdmin: Bool
}
