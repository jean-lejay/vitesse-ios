//
//  RootView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/5/26.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var session: SessionViewModel
    
    let dependencies: AppDependencies
    
    var body: some View {
        if session.isAuthenticated {
            CandidatesListView()
        } else {
            LoginView(viewmodel: LoginViewModel(authRepository: dependencies.authRepository, session: session), dependencies: dependencies)
        }
    }
}
