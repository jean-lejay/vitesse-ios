//
//  RegisterFormData.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

struct RegisterFormData {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

extension RegisterFormData {
    func toDTO() -> RegisterUserRequestDTO {
        RegisterUserRequestDTO(firstName: firstName, lastName: lastName, email: email, password: password)
    }
}
