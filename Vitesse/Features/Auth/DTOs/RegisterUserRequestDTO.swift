//
//  RegisterUserRequestDTO.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.
//

struct RegisterUserRequestDTO: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
