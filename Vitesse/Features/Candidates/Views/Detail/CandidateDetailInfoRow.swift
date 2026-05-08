//
//  CandidateDetailInfoRow.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/8/26.
//

import SwiftUI

struct CandidateDetailInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(value.isEmpty ? "—" : value)
                .font(.body)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
