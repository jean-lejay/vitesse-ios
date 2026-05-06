//
//  ErrorBannerView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/6/26.
//

import SwiftUI

struct ErrorBannerView: View {
    let message: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.red)
            
            Text(message)
                .font(.caption)
                .foregroundStyle(.red)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(10)
        .background(Color.red.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.top, 8)
    }
}
