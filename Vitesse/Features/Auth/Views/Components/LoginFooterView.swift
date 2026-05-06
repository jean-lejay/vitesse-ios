//
//  LoginFooterView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/6/26.
//

import SwiftUI

struct LoginFooterView: View {
    
    let dependencies: AppDependencies
    
    var body: some View {
        HStack {
            Text("Don't have an account?")
            
            NavigationLink {
                RegisterView(
                    viewmodel: RegisterViewModel(
                        authRepository: dependencies.authRepository
                    )
                )
            } label: {
                Text("Register")
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical)
    }
}
