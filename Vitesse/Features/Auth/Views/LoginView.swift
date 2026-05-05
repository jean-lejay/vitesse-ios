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
    @State private var identifiersCorrect = false
    
    private var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
        
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Login")
                        .font(.title)
                    Text("Enter your email and password to login")
                        .font(.caption)
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                        TextField("", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                        
                        Text("Password")
                        SecureField("", text: $password)
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Spacer()
                            Text("Forgot Password?")
                                .font(.caption)
                                .foregroundStyle(.green)
                        }
                        
                        if let errorMessage = viewmodel.errorMessage {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundStyle(.red)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.vertical)
                    
                }

                Button {
                    Task {
                        await viewmodel.login(email: email, password: password)
                    }
                    
                } label: {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.green : Color.green.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isFormValid)
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Register")
                                .foregroundStyle(.green)
                        }
                }
                .padding(.vertical)
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

// vérifier que le format est bien celui d'un email
// Griser le bouton tant que ce n'est pas bon
// afficher les messages d'erreur
// Progress View
