//
//  CandidateDTO.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/22/26.
//

import Foundation

struct CandidateDTO: Decodable {
    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    let phone: String?
    let linkedinURL: String?
    let note: String?
    let isFavorite: Bool
}

extension CandidateDTO {
    func toModel() -> Candidate {
        Candidate(id: id, firstName: firstName, lastName: lastName, email: email, phone: phone, linkedinURL: linkedinURL, note: note, isFavorite: isFavorite)
    }
}

