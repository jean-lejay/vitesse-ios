//
//  LoginView.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var identifiersCorrect: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Login")
                        .font(.title)
                    Text("Enter your email and password to login")
                        .font(.caption)
                    
                    VStack(alignment: .leading) {
                        // vérifier le format de l'email
                        Text("Email")
                        TextField("", text: $email)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Password")
                        SecureField("", text: $password)
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Spacer()
                            Text("Forgot Password?")
                                .font(.caption)
                                .foregroundStyle(.green)
                        }
                    }
                    .padding(.vertical)
                    
                }
                
                // ProgressView

                Button {
                    identifiersCorrect = true
                } label: {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
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
            .navigationDestination(isPresented: $identifiersCorrect) {
                CandidatesListView()
            }
            .padding()
        }
        
    }
}

#Preview {
    LoginView()
}
