//
//  LoginHeaderView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/6/26.
//

import SwiftUI

struct AuthHeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
            Text(subtitle)
                .font(.caption)
        }
    }
}
