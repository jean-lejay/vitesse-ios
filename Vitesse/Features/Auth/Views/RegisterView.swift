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
    @State private var confirmPassword: String = ""
    
    @FocusState private var focusedField: RegisterFormView.Field?
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        viewmodel.canSubmit(formData: formData, confirmPassword: confirmPassword)
    }
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                AuthHeaderView(title: "Register", subtitle: "Create Your Vitesse account")
                
                RegisterFormView(formData: $formData, confirmPassword: $confirmPassword, focusedField: $focusedField, errorMessage: viewmodel.errorMessage) { oldFocusedField, newFocusedField in
                    
                    if newFocusedField == .email {
                        viewmodel.startEditingEmail()
                    } else if oldFocusedField == .email, !formData.email.isEmpty {
                        viewmodel.validateEmail(formData.email)
                    }
                    
                    if (oldFocusedField == .password || oldFocusedField == .confirmPassword) &&
                        newFocusedField != .password &&
                        newFocusedField != .confirmPassword {
                        viewmodel.validatePasswords(
                            password: formData.password,
                            confirmPassword: confirmPassword
                        )
                    }
                }
            }
            
            PrimaryLoadingButton(title: "Create", isLoading: viewmodel.isLoading, isEnabled: isFormValid) {
                Task {
                    await viewmodel.register(formData: formData, confirmPassword: confirmPassword)
                }
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
