//
//  CandidateDetailInputRow.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/8/26.
//

import SwiftUI

struct CandidateDetailInputRow: View {
    
    let title: String
    @Binding var text: String
    
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    var autocorrectionDisabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            TextField(title, text: $text)
                .textFieldStyle(.plain)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled(autocorrectionDisabled)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
