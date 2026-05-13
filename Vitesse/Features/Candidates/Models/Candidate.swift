//
//  Data.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import Foundation

struct Candidate: Identifiable {
    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    let phone: String?
    let linkedinURL: String?
    var note: String?
    var isFavorite: Bool
}

extension Candidate {
    func toFormData() -> CandidateFormData {
        CandidateFormData(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone ?? "",
            linkedinURL: linkedinURL ?? "",
            note: note ?? ""
        )
    }
}

