//
//  CandidateFormData.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

import Foundation

struct CandidateFormData {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var linkedinURL: String
    var note: String
}

extension CandidateFormData {
    
    private func emptyToNil(_ value: String) -> String? {
            value.isEmpty ? nil : value
    }
    
    func toCreateCandidateRequestDTO() -> CandidateRequestDTO {
        CandidateRequestDTO(firstName: firstName, lastName: lastName, email: email, phone: emptyToNil(phone), linkedinURL: emptyToNil(linkedinURL), note: emptyToNil(note))
    }
    
    func toUpdateCandidateRequestDTO() -> CandidateRequestDTO {
        CandidateRequestDTO(firstName: firstName, lastName: lastName, email: email, phone: emptyToNil(phone), linkedinURL: emptyToNil(linkedinURL), note: emptyToNil(note))
    }
}
