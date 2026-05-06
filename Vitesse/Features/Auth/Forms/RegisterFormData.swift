//
//  RegisterFormData.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

struct RegisterFormData {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
}

extension RegisterFormData {
    func toDTO() -> RegisterUserRequestDTO {
        RegisterUserRequestDTO(firstName: firstName, lastName: lastName, email: email, password: password)
    }
}
