//
//  CandidateDetailView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/5/26.
//

import SwiftUI

struct CandidateDetailView: View {
    
    @StateObject var viewmodel: CandidateDetailViewModel
    @State private var isEditing = false
    @State private var formData: CandidateFormData
    @FocusState private var focusedField: Field?
    
    private enum Field {
        case email
        case linkedin
    }
    
    let candidate: Candidate
    let isAdmin: Bool
    
    private var displayedCandidate: Candidate {
        viewmodel.candidateDetail ?? candidate
    }
    
    init(viewmodel: CandidateDetailViewModel, isAdmin: Bool, candidate: Candidate) {
        _viewmodel = StateObject(wrappedValue: viewmodel)
        self.isAdmin = isAdmin
        self.candidate = candidate
        _formData = State(initialValue: candidate.toFormData())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            CandidateDetailToolbarView(
                isEditing: $isEditing,
                onCancel: {
                    viewmodel.clearError()
                    formData = displayedCandidate.toFormData()
                    isEditing = false },
                onUpdate: {
                    Task {
                        await viewmodel.updateCandidate(candidateId: displayedCandidate.id, formData: formData)
                        
                        if viewmodel.errorMessage == nil {
                            isEditing = false
                        }
                    }
                }
            )
            
            if let errorMessage = viewmodel.errorMessage {
                ErrorBannerView(message: errorMessage)
            }
            
            CandidateDetailHeaderView(displayedCandidate: displayedCandidate, isEditing: isEditing, isAdmin: isAdmin,
                onFavoriteTapped: {
                    Task {
                        await viewmodel.setCandidateFavorite(candidateId: displayedCandidate.id)
                    }
                }
            )
            
            if isEditing {
                CandidateDetailEditFormView(
                    formData: $formData,
                    onEmailEditingStarted: {
                        viewmodel.startEditingEmail()
                    },
                    onEmailEditingEnded: {
                        if !formData.email.isEmpty {
                            viewmodel.validateEmail(formData.email)
                        }
                    },
                    onLinkedInEditingEnded: {
                        viewmodel.validateLinkedInURL(formData.linkedinURL)
                    }
                )
            } else {
                CandidateDetailReadOnlyView(displayedCandidate: displayedCandidate)
            }
            
            Spacer()
        }
        .padding()
        .disabled(viewmodel.isLoading)
        .overlay {
            if viewmodel.isLoading {
                ProgressView()
                    .scaleEffect(1.2)
            }
        }
    }
}



