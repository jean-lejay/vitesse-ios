//
//  CandidateSearchBarView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/7/26.
//

import SwiftUI

struct CandidateSearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Search", text: $searchText)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.bottom, 8)
    }
}
