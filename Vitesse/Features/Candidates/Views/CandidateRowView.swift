//
//  CandidateRowView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/7/26.
//

import SwiftUI

struct CandidateRowView: View {
    
    let candidate: Candidate
    @Binding var isEditing: Bool
    @Binding var selectedCandidateIds: Set<UUID>
    
    var body: some View {
        HStack {
            if isEditing {
                // bouton de sélection en mode édition
                Button {
                    if selectedCandidateIds.contains(candidate.id) {
                        selectedCandidateIds.remove(candidate.id)
                    } else {
                        selectedCandidateIds.insert(candidate.id)
                    }
                } label: {
                    Image(systemName: selectedCandidateIds.contains(candidate.id) ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(selectedCandidateIds.contains(candidate.id) ? .green : .gray)
                        .font(.title3)
                }
            }
            Text("\(candidate.firstName) \(candidate.lastName)")
            Spacer()
            Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                .foregroundStyle(candidate.isFavorite ? Color.yellow.opacity(0.85) : .gray)
        }
        .frame(height: 30)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
}
