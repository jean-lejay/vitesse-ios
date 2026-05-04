//
//  CandidatesListView.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import SwiftUI

struct CandidatesListView: View {
    @State private var searchText = ""
    
    var filteredCandidates: [Candidate] {
        if searchText.isEmpty { return candidates }
        return candidates.filter {
            $0.firstName.localizedCaseInsensitiveContains(searchText) ||
            $0.lastName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(filteredCandidates) { candidate in
                    HStack {
                        Text("\(candidate.firstName) \(candidate.lastName)")
                        Spacer()
                        Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                    }
                    .padding()
                    .border(.black)
                }
            }
        }
        .searchable(text: $searchText)
    }
}


    
#Preview {
    CandidatesListView()
    TestBackendView()
}
