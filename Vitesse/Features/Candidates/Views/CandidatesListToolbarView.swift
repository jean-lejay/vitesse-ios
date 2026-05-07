//
//  CandidatesListToolbarView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/7/26.
//

import SwiftUI

struct CandidatesListToolbarView: View {
    
    @Binding var showFavoritesOnly: Bool
    @Binding var isEditing: Bool
    @Binding var selectedCandidateIds: Set<UUID>
    
    let onDelete: () -> Void
    
    var body: some View {
        
        if isEditing {
            HStack {
                Button("Cancel") {
                    isEditing = false
                    selectedCandidateIds.removeAll()
                }
                Spacer()
                Button("Delete") {
                    onDelete()
                }
                .foregroundStyle(.red)
                .disabled(selectedCandidateIds.isEmpty)
            }
            .frame(height: 30)
        } else {
            HStack {
                Button("Edit") {
                    isEditing = true
                }
                Spacer()
                Button {
                    showFavoritesOnly.toggle()
                } label: {
                    Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                        .foregroundStyle(showFavoritesOnly ? Color.yellow.opacity(0.85): .gray)
                        .font(.title3)
                }
                .padding(.trailing,13)
            }
            .frame(height: 30)
        }
    }
}
