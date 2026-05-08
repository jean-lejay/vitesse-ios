//
//  CandidatesListContentView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/7/26.
//

import SwiftUI

struct CandidatesListContentView: View {
    
    let candidates: [Candidate]
    let errorMessage: String?
    let isLoading: Bool
    
    @Binding var isEditing: Bool
    @Binding var selectedCandidateIds: Set<UUID>
    
    let dependencies: AppDependencies
    let session: SessionViewModel
    
    var body: some View {
        if let errorMessage {
            ErrorBannerView(message: errorMessage)
        } else if isLoading {
            ProgressView()
                .padding(.top, 24)
        } else if candidates.isEmpty {
            // Liste de candidats vide
            ContentUnavailableView("No candidates", systemImage: "person.crop.circle.badge.questionmark", description: Text("No candidates match your search.")
            )
            .padding(.top, 24)
        } else {
            ForEach(candidates) { candidate in
                
                if isEditing {
                    CandidateRowView(candidate: candidate, isEditing: $isEditing, selectedCandidateIds: $selectedCandidateIds)
                } else {
                    NavigationLink {
                        CandidateDetailView(viewmodel: CandidateDetailViewModel(repository: dependencies.candidateRepository, session: session), isAdmin: session.isAdmin, candidate: candidate)
                    } label: {
                        CandidateRowView(candidate: candidate, isEditing: $isEditing, selectedCandidateIds: $selectedCandidateIds)
                    }
                    .buttonStyle(.plain)
                }
                
            }
        }
    }
}
