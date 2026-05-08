//
//  CandidateDetailReadOnlyView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/8/26.
//

import SwiftUI

struct CandidateDetailReadOnlyView: View {
    let displayedCandidate: Candidate
    
    var body: some View {
        VStack(spacing: 12) {
            CandidateDetailInfoRow(
                title: "Phone",
                value: displayedCandidate.phone?.formattedFrenchPhoneNumber ?? ""
            )
            
            CandidateDetailInfoRow(
                title: "Email",
                value: displayedCandidate.email
            )
            
            CandidateDetailInfoRow(
                title: "LinkedIn",
                value: displayedCandidate.linkedinURL ?? ""
            )
            
            CandidateDetailInfoRow(
                title: "Note",
                value: displayedCandidate.note ?? ""
            )
        }
    }
}
