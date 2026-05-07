//
//  LoginView.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var session: SessionViewModel
    @StateObject var viewmodel: LoginViewModel
    let dependencies: AppDependencies
    
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var emailFocused: Bool
    
    private var isFormValid: Bool {
        viewmodel.canSubmit(email: email, password: password)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    AuthHeaderView(title: "Login", subtitle: "Enter your email and password to login")
                    
                    LoginFormView(email: $email, password: $password, emailFocused: $emailFocused) {
                        isFocused in
                        if isFocused {
                            viewmodel.startEditingEmail() // pas de message d'erreur affiché lors de la saisie de l'adresse email
                        } else if !email.isEmpty {
                            viewmodel.validateEmail(email)
                        }
                    }
                    .padding(.top)
                    
                    if let errorMessage = viewmodel.errorMessage {
                        ErrorBannerView(message: errorMessage)
                    }
                }
                .padding(.vertical)
                
                PrimaryLoadingButton(title: "Sign in", isLoading: viewmodel.isLoading, isEnabled: isFormValid) {
                    Task {
                        await viewmodel.login(email: email, password: password)
                    }
                }
                
                LoginFooterView(dependencies: dependencies)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    let session = SessionViewModel()
    let dependencies = AppDependencies()
    
    let viewModel = LoginViewModel(authRepository: AuthRepository(apiClient: APIClient()), session: session)
    
    LoginView(viewmodel: viewModel, dependencies: dependencies)
        .environmentObject(session)
}
