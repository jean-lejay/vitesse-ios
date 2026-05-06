//
//  RegisterView.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/15/26.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewmodel: RegisterViewModel
    @State private var formData = RegisterFormData()
    @State private var passwordConfirmation: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
                    TextField("", text: $formData.firstName)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Last Name")
                    TextField("", text: $formData.lastName)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Email")
                    TextField("", text: $formData.email)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Password")
                    SecureField("", text: $formData.password)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Confirm Password")
                    SecureField("", text: $passwordConfirmation)
                        .textFieldStyle(.roundedBorder)
                    
                }
                .padding(.vertical)
                
            }
            
            Button {
                Task {
                    await viewmodel.register(formData: formData)
                }
            } label: {
                Text("Create")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer()
            
        }.onChange(of: viewmodel.isRegistrationSuccessful) {
            if viewmodel.isRegistrationSuccessful {
                dismiss()
            }
        }
        
        .padding()
    }
}

//#Preview {
//    RegisterView()
//}
