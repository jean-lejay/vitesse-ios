//
//  CandidatesListView.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import SwiftUI

struct CandidatesListView: View {
    
    @EnvironmentObject var session: SessionViewModel
    @StateObject var viewmodel: CandidatesListViewModel
    let dependencies: AppDependencies
    
    @State private var searchText = ""
    @State private var showFavoritesOnly = false
    @State private var isEditing = false
    @State private var selectedCandidateIds: Set<UUID> = []
    
    private var filteredCandidates: [Candidate] {
        viewmodel.candidates.filter { candidate in
            let matchesSearch =
            searchText.isEmpty ||
            candidate.firstName.localizedCaseInsensitiveContains(searchText) ||
            candidate.lastName.localizedCaseInsensitiveContains(searchText)
            
            let matchesFavorite = !showFavoritesOnly || candidate.isFavorite
            
            return matchesSearch && matchesFavorite
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CandidatesListToolbarView(showFavoritesOnly: $showFavoritesOnly, isEditing: $isEditing, selectedCandidateIds: $selectedCandidateIds) {
                        Task {
                            await viewmodel.deleteCandidates(candidateIds: selectedCandidateIds)
                            selectedCandidateIds.removeAll()
                            isEditing = false
                        }
                    }
                    
                    CandidateSearchBarView(searchText: $searchText)
                    
                    CandidatesListContentView(candidates: filteredCandidates, errorMessage: viewmodel.errorMessage, isLoading: viewmodel.isLoading, isEditing: $isEditing, selectedCandidateIds: $selectedCandidateIds)
                }
                .padding()
            }
            .navigationTitle("Candidates")
            .task {
                await viewmodel.fetchCandidates()
            }
        }
    }
}

