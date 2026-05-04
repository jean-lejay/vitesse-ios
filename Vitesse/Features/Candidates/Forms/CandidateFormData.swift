//
//  CandidateFormData.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

import Foundation

struct CandidateFormData {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String?
    let linkedinURL: String?
    let note: String?
}

extension CandidateFormData {
    func toCreateCandidateRequestDTO() -> CandidateRequestDTO {
        CandidateRequestDTO(firstName: firstName, lastName: lastName, email: email, phone: phone, linkedinURL: linkedinURL, note: note)
    }
    
    func toUpdateCandidateRequestDTO() -> CandidateRequestDTO {
        CandidateRequestDTO(firstName: firstName, lastName: lastName, email: email, phone: phone, linkedinURL: linkedinURL, note: note)
    }
}
