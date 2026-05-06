//
//  PrimaryLoadingButton.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/6/26.
//

import SwiftUI

struct PrimaryLoadingButton: View {
    let title: String
    let isLoading: Bool
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .disabled(!isEnabled || isLoading)
        .background(isEnabled ? Color.green : Color.gray)
        .foregroundColor(.white)
        .fontWeight(isEnabled ? .bold : .regular)
        .cornerRadius(8)
    }
}
