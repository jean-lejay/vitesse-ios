//
//  CreateCandidateRequestDTO.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/22/26.
//

import Foundation

struct CreateCandidateRequestDTO: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String?
    let linkedinURL: String?
    let note: String?
}
