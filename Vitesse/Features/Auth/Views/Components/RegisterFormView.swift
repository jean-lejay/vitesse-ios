//
//  RegisterFormView.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/6/26.
//

import SwiftUI

struct RegisterFormView: View {
    
    enum Field: Equatable {
        case email
        case password
        case confirmPassword
    }
    
    @Binding var formData: RegisterFormData
    @Binding var confirmPassword: String
    
    @FocusState.Binding var focusedField: Field?
    
    let errorMessage: String?
    let onFocusChanged: (Field?, Field?) -> Void
    
    var body: some View {
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
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .focused($focusedField, equals: .email)
            
            Text("Password")
            SecureField("", text: $formData.password)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .password)
            
            Text("Confirm Password")
            SecureField("", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .confirmPassword)
            
            if let errorMessage = errorMessage {
                ErrorBannerView(message: errorMessage)
            }
            
        }
        .padding(.vertical)
        .onChange(of: focusedField) { oldFocusedField, newFocusedField in
            onFocusChanged(oldFocusedField, newFocusedField)
        }
    }
}
