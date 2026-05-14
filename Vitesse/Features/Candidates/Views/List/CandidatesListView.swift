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
    
    @State private var isEditing = false
    @State private var selectedCandidateIds: Set<UUID> = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CandidatesListToolbarView(showFavoritesOnly: $viewmodel.showFavoritesOnly, isEditing: $isEditing, selectedCandidateIds: $selectedCandidateIds) {
                        Task {
                            await viewmodel.deleteCandidates(candidateIds: selectedCandidateIds)
                            selectedCandidateIds.removeAll()
                            isEditing = false
                        }
                    }
                    
                    CandidateSearchBarView(searchText: $viewmodel.searchText)
                    
                    CandidatesListContentView(candidates: viewmodel.filteredCandidates, errorMessage: viewmodel.errorMessage, isLoading: viewmodel.isLoading, isEditing: $isEditing, selectedCandidateIds: $selectedCandidateIds, dependencies: dependencies, session: session)
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

