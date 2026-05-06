//
//  LoginFormView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/6/26.
//

import SwiftUI

struct LoginFormView: View {
    
    @Binding var email: String
    @Binding var password: String
    @FocusState.Binding var emailFocused: Bool
    
    let onEmailFocusChanged: (Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email")
            TextField("", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .focused($emailFocused)
                .onChange(of: emailFocused) { _, isFocused in
                    onEmailFocusChanged(isFocused)
                }
            
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
    }
}
