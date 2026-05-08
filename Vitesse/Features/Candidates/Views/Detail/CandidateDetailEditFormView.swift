//
//  CandidateDetailEditFormView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/8/26.
//

import SwiftUI

struct CandidateDetailEditFormView: View {
    @Binding var formData: CandidateFormData
    
    enum Field {
        case email
        case linkedIn
    }
    
    @FocusState private var focusedField: Field?
    
    let onEmailEditingStarted: () -> Void
    let onEmailEditingEnded: () -> Void
    let onLinkedInEditingEnded: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading) {
            CandidateDetailInputRow(
                title: "Phone",
                text: $formData.phone,
                keyboardType: .phonePad,
                autocapitalization: .never,
                autocorrectionDisabled: true
            )
            
            CandidateDetailInputRow(
                title: "Email",
                text: $formData.email,
                keyboardType: .emailAddress,
                autocapitalization: .never,
                autocorrectionDisabled: true
            )
            .focused($focusedField, equals: .email)
            
            CandidateDetailInputRow(
                title: "LinkedIn",
                text: $formData.linkedinURL,
                keyboardType: .URL,
                autocapitalization: .never,
                autocorrectionDisabled: true
            )
            .focused($focusedField, equals: .linkedIn)
            
            CandidateDetailTextEditorRow(title: "Note", text: $formData.note)
            
        }
        .onChange(of: focusedField) { oldField, newField in
            if newField == .email {
                onEmailEditingStarted()
            }
            if oldField == .email && newField != .email {
                onEmailEditingEnded()
            }
            if oldField == .linkedIn && newField != .linkedIn {
                onLinkedInEditingEnded()
            }
        }
    }
}
