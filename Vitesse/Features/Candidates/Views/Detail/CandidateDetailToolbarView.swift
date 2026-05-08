//
//  CandidateDetailToolbarView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/7/26.
//

import SwiftUI

struct CandidateDetailToolbarView: View {
    
    @Binding var isEditing: Bool
    
    let onCancel: () -> Void
    let onUpdate: () -> Void
    
    var body: some View {
        HStack {
            if isEditing {
                Button("Cancel") {
                    onCancel()
                }
                Spacer()
                Button("Done") {
                    onUpdate()
                }
            } else {
                Spacer()
                Button("Edit") {
                    isEditing = true
                }
            }
        }
        .frame(height: 30)
    }
}
