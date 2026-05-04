//
//  Data.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import Foundation

struct Candidate: Identifiable {
    var id = UUID()
    let firstName: String
    let lastName: String
    let telephone: String
    let email: String
    let linkedinURL: String
    var notes: String
    var isFavorite: Bool
}

var candidates: [Candidate] = [
    Candidate(
        firstName: "Jean",
        lastName: "Dupont",
        telephone: "0612345678",
        email: "jean.dupont@email.com",
        linkedinURL: "https://www.linkedin.com/in/jeandupont",
        notes: "iOS developer junior, très motivé",
        isFavorite: true
    ),
    Candidate(
        firstName: "Marie",
        lastName: "Martin",
        telephone: "0623456789",
        email: "marie.martin@email.com",
        linkedinURL: "https://www.linkedin.com/in/mariemartin",
        notes: "Bonne expérience en SwiftUI",
        isFavorite: false
    ),
    Candidate(
        firstName: "Thomas",
        lastName: "Bernard",
        telephone: "0634567890",
        email: "thomas.bernard@email.com",
        linkedinURL: "https://www.linkedin.com/in/thomasbernard",
        notes: "Profil backend, à évaluer sur iOS",
        isFavorite: false
    ),
    Candidate(
        firstName: "Sophie",
        lastName: "Petit",
        telephone: "0645678901",
        email: "sophie.petit@email.com",
        linkedinURL: "https://www.linkedin.com/in/sophiepetit",
        notes: "Très bon fit produit, UX solide",
        isFavorite: true
    ),
    Candidate(
        firstName: "Lucas",
        lastName: "Moreau",
        telephone: "0656789012",
        email: "lucas.moreau@email.com",
        linkedinURL: "https://www.linkedin.com/in/lucasmoreau",
        notes: "Encore junior mais progression rapide",
        isFavorite: false
    )
]
