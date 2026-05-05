//
//  RegisterView.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var credentialsValid: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 16){
                        Text("Register")
                            .font(.title)
                        Text("Create Your Vitesse account")
                            .font(.caption)
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("First Name")
                        TextField("", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Last Name")
                        TextField("", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Email")
                        TextField("", text: $email)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Password")
                        SecureField("", text: $password)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Confirm Password")
                        SecureField("", text: $password2)
                            .textFieldStyle(.roundedBorder)
            
                    }
                    .padding(.vertical)
                    
                }
                
                Button {
                    credentialsValid = true
                } label: {
                    Text("Create")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
                
            }
            .navigationDestination(isPresented: $credentialsValid) {
                //LoginView()
            }
            .padding()
        }
        
    }
}

#Preview {
    RegisterView()
}
