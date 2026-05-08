//
//  CandidateDetailHeaderView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/8/26.
//

import SwiftUI

struct CandidateDetailHeaderView: View {
    let displayedCandidate: Candidate
    let isEditing: Bool
    let isAdmin: Bool
    
    let onFavoriteTapped: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(displayedCandidate.firstName) \(displayedCandidate.lastName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            if !isEditing {
                Button {
                    onFavoriteTapped()
                } label: {
                    Image(systemName: displayedCandidate.isFavorite ? "star.fill" : "star")
                        .foregroundStyle(displayedCandidate.isFavorite ? Color.yellow.opacity(0.85): .gray)
                        .font(.largeTitle)
                }
                .disabled(!isAdmin)
            }
        }
    }
}
